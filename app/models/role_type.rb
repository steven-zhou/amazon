class RoleType < AmazonSetting

  acts_as_list

  has_many :roles

  validates_presence_of :name
  validates_uniqueness_of :name, :message => "A role type already exists with the same name."

  after_create :assign_priority
  before_destroy :reorder_priority
  after_save :update_roles

  def self.active_role_type
    @role_type = RoleType.find(:all, :conditions => ["status = true and to_be_removed = false"], :order => 'name')
  end

  private

  def assign_priority
    self.move_to_bottom
  end

  def reorder_priority
    self.remove_from_list
  end

  def update_roles
    if self.to_be_removed == true
      self.roles.each do |i|
        i.to_be_removed = true
        i.save
      end
    end
  end
  
end
