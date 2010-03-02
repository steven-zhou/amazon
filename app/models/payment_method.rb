class PaymentMethod < Tag

  acts_as_list
  belongs_to :contact_meta_type, :class_name => "ContactMetaType", :foreign_key => "tag_type_id"


  has_many :employments
  has_many :membership_fees,:class_name =>"MembershipFee",:foreign_key => "smembership_id"

  validates_presence_of :name
  validates_uniqueness_of :name, :message => "A payment method already exists with the same name."


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

