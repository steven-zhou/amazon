class GroupType < Tag

  acts_as_list

  belongs_to :group_meta_type, :class_name => "GroupMetaType", :foreign_key => "tag_type_id"
  #has_many :groups, :class_name => "Group", :foreign_key => "tags_id"
  has_many :user_groups, :foreign_key => "group_id"
  has_many :login_accounts, :through => :user_groups, :uniq => true

  has_many :group_lists, :foreign_key => "tag_id"
  has_many :list_headers, :through => :group_lists, :uniq => true


  has_many :group_permissions, :foreign_key => "user_group_id"
  has_many :system_permission_types, :through => :group_permissions
  
  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :tag_type_id, :message => "A group type already exists with the same name."

  default_scope :order => "name ASC"

  after_create :assign_priority
  before_destroy :reorder_priority




  def group_person_lists
    person_lists = Array.new
    self.list_headers.each do |i|
      if i.person_list?
        person_lists << i
      end
    end
    person_lists
  end



  def group_organisation_lists
    organisation_lists = Array.new
    self.list_headers.each do |i|
      unless i.person_list?
        organisation_lists << i
      end
    end
    organisation_lists
  end

  private

  def assign_priority
    self.move_to_bottom
  end

  def reorder_priority
    self.remove_from_list
  end

  def self.system_user_groups
   c = GroupMetaType.find(:first, :conditions => ["name=?","System Users"])
   @group_types = c.group_types rescue @group_types = Array.new

  end

end

