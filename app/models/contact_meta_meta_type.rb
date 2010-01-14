class ContactMetaMetaType < TagMetaType

  acts_as_list

  has_many :contact_meta_types, :class_name => "ContactMetaType", :foreign_key => "tag_meta_type_id"

  validates_presence_of :name
  validates_uniqueness_of :name

  named_scope :email, :conditions => {:name => "Email", :status => true, :to_be_removed => false}
  named_scope :phone, :conditions => {:name => "Phone", :status => true, :to_be_removed => false}
  named_scope :website, :conditions => {:name => "Website", :status => true, :to_be_removed => false}
  named_scope :im, :conditions => {:name => "IM", :status => true, :to_be_removed => false}
  

  after_create :assign_priority
  before_destroy :reorder_priority

  private

  def assign_priority
    self.move_to_bottom
  end

  def reorder_priority
    self.remove_from_list
  end

end
