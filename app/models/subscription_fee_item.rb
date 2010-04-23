class SubscriptionFeeItem < FeeItem
  belongs_to :fee_type, :class_name => "SubscriptionFeeType", :foreign_key => "tag_type_id"

end
