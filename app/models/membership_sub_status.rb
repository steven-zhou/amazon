class MembershipSubStatus < AmazonSetting

  acts_as_list
  has_one :membership
  validates_presence_of :name
  validates_uniqueness_of :name

  after_create :assign_priority
  before_destroy :reorder_priority


  def self.initiated

    MembershipSubStatus.find_all_by_name("Prospective")

  end

  def self.review_option
    [MembershipSubStatus.find_by_name("Prospective"), MembershipSubStatus.find_by_name("In-review")]
  end

  def self.finalize_option
    [MembershipSubStatus.find_by_name("Pre-active"), MembershipSubStatus.find_by_name("Rejected")]
  end
  private

  def assign_priority
    self.move_to_bottom
  end

  def reorder_priority
    self.remove_from_list
  end
end
