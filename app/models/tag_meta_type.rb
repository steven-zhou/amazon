class TagMetaType < ActiveRecord::Base

  OPTIONS = ['SystemPermission', 'MasterDoc', 'Group', 'Fee', 'Table', 'Contact']

  has_many :tag_types
  
  validates_presence_of :name
  validates_uniqueness_of :name, :scope => [:type], :case_sensitive => false


  named_scope :active, :conditions => {:status => true, :to_be_removed => false}
  named_scope :inactive, :conditions => {:status => false}
  named_scope :removed, :conditions => {:to_be_removed => true}

  before_destroy :delete_all_children
  after_save :update_children_when_delete
  
  def self.distinct_types_of_tag_meta_types
    @tag_meta_types = TagMetaType.find(:all, :select => "DISTINCT type")
    results = ""
    @tag_meta_types.each { |setting| results += "<option value='" + "#{setting.type}" + "'>" + "#{setting.type}" + "</option>" }
    return results
  end

  def self.active_group_meta_type
    @group_meta_type = GroupMetaMetaType.find(:all, :conditions => ["status = true"], :order => 'name')
  end

  def self.active_custom_type
    @group_meta_type = GroupMetaMetaType.find(:all, :conditions => ["name = ?" , 'Custom'], :order => 'name')
  end

  def retrieve_all_children
    self.to_be_removed = false
    self.save
    self.tag_types.each do |m|

      m.tags.each do |i|
        i.to_be_removed = false
        i.save
      end

      m.to_be_removed = false
      m.save
    end

  end


  private

  def delete_all_children
    self.tag_types.each do |i|
      i.destroy
    end
  end

  #this method to set the master_doc_meta_types "to_be_removed" to true
  def update_children_when_delete
    if self.to_be_removed == true
      self.tag_types.each do |m|
        if m.to_be_removed == false
          m.to_be_removed = true
          m.save
        end
      end
    end
  end


end
