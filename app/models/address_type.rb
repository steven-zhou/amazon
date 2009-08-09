class AddressType < AmazonSetting

  acts_as_list

  has_many :addresses

  validates_presence_of :name
  validates_uniqueness_of :name, :message => "An address type already exists with the same name."

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
