class FeeItemType < TagType
  acts_as_list

  belongs_to :fee_item_meta_type, :class_name => "FeeItemMetaType", :foreign_key => "tag_meta_type_id"
  has_many :membership_fee_items, :class_name => "MembershipFeeItem", :foreign_key => "tag_type_id"
  has_many :subscription_fee_items, :class_name => "SubscriptionFeeItem", :foreign_key => "tag_type_id"

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :tag_meta_type_id, :message => "A fee item  type already exists with the same name."

  after_create :assign_priority,:update_to_be_removed_and_status
  before_destroy :reorder_priority

  private

  def assign_priority
    self.move_to_bottom
  end

  def reorder_priority
    self.remove_from_list
  end

      def update_to_be_removed_and_status

    self.to_be_removed = false
    self.status = true
  end
end
