class SuspensionType < AmazonSetting

  acts_as_list

  has_many :employments

  validates_presence_of :name
  validates_uniqueness_of :name, :message => "A suspension type already exists with the same name."

  after_create :assign_priority
  before_destroy :reorder_priority

  def self.active_suspension_type
    @suspension_type = SuspensionType.find(:all, :conditions => ["status = true"], :order => 'name')
  end

  private

  def assign_priority
    self.move_to_bottom
  end

  def reorder_priority
    self.remove_from_list
  end
  
end
