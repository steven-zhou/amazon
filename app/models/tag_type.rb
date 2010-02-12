class TagType < ActiveRecord::Base

  belongs_to :tag_meta_type
  has_many :tags

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => [:type, :tag_meta_type_id], :case_sensitive => false

  default_scope :order => "name ASC"
  named_scope :active, :conditions => {:status => true, :to_be_removed => false}
  named_scope :inactive, :conditions => {:status => false}
  named_scope :removed, :conditions => {:to_be_removed => true}

  accepts_nested_attributes_for :tags, :reject_if => proc { |attributes| attributes['name'].blank? || attributes['tag_type_id'].blank? }

  before_destroy :delete_all_children
  after_save :update_children_when_delete, :update_parent_when_retrieve
  
  def self.distinct_types_of_tag_types
    @tag_types = TagType.find(:all, :select => "DISTINCT type")
    results = ""
    @tag_types.each { |setting| results += "<option value='" + "#{setting.type}" + "'>" + "#{setting.type}" + "</option>" }
    return results
  end

  

  #  def remove_all_children
  #    self.to_be_removed = true
  #    self.save
  #
  #    self.tags.each do |i|
  #      i.to_be_removed = true
  #      i.save
  #    end
  #  end


  def retrieve_all_children
    self.to_be_removed = false
    self.save

    self.tags.each do |i|
      i.to_be_removed = false
      i.save
    end
  end

  def self.show_meta_type
    @group_meta_meta_type = GroupMetaMetaType.find(:all, :conditions => ["name = ?" , 'Custom'], :order => 'name')
    @group_meta_type = GroupMetaType.find(:all, :conditions => ["tag_meta_type_id = ? AND status = true and to_be_removed = false", @group_meta_meta_type.first.id], :order => 'name')
  end

  private
  
  def delete_all_children
    self.tags.each do |i|
      i.destroy
    end
  end

  def update_children_when_delete
    if self.to_be_removed == true
      self.tags.each do |i|
        if i.to_be_removed == false
          i.to_be_removed = true
          i.save
        end
      end
    end
  end

  def update_parent_when_retrieve
    if self.to_be_removed == false && self.tag_meta_type.to_be_removed == true
      self.tag_meta_type.to_be_removed = false
      self.tag_meta_type.save
    end
  end
end
