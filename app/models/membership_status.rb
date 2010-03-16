class MembershipStatus < AmazonSetting

  acts_as_list

  has_one :membership

  validates_presence_of :name
  validates_uniqueness_of :name

  after_create :assign_priority
  before_destroy :reorder_priority

  def self.initiated
    MembershipStatus.find_all_by_name("Prospective")
  end

  def self.review_option
    MembershipStatus.find(:all, :conditions => ["name IN (?)", ["In-review", "Actived", "Rejected"]])
  end

  def self.approve
    MembershipStatus.find_by_name("Actived")
  end


  def self.terminate
    MembershipStatus.find_by_name("Terminated")
  end

  def self.reject
    MembershipStatus.find_by_name("Rejected")
  end

  def self.remove
    MembershipStatus.find_by_name("Removed")
  end

  def self.archive
    MembershipStatus.find_by_name("Archived")
  end

  def self.prospective
    MembershipStatus.find_by_name("Prospective")
  end
  
  def self.in_review
    MembershipStatus.find_by_name("In-review")
  end



  def self.join_membership_status(array)

    type = []
    array.each do |a|
      type <<  a
    end
    type = type.join(',')
  end

  def self.all_end_cycle
    status = ["Rejected","Terminated","Removed","Archived"]
    MembershipStatus.find(:all, :conditions => ["Name IN (?)",status ])
  end

  def self.all_life
    status = ["Actived"]
    MembershipStatus.find(:all, :conditions => ["Name IN (?)",status ])
  end
  private
  
  def assign_priority
    self.move_to_bottom
  end

  def reorder_priority
    self.remove_from_list
  end


  
end
