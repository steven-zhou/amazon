class MembershipFeeItem < FeeItem
    belongs_to :fee_type, :class_name => "MembershipFeeType", :foreign_key => "tag_type_id"
end
