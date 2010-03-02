class MembershipFeeItem < FeeItem
    has_many :membership_fees,:class_name=>"MembershipFee",:foreign_key=>"fee_item_id"
end
