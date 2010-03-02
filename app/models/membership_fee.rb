class MembershipFee < ActiveRecord::Base

  belongs_to :fee_item ,     :class_name => "FeeItem", :foreign_key => "fee_item_id"
  belongs_to :membership,    :class_name=>"Membership",:foreign_key => "membership_id"
  belongs_to :payment_method,:class_name=>"PaymentMethod",:foreign_key => "payment_method_id"
  belongs_to :receipt_account,:class_name =>"ReceiptAccount",:foreign_key => "receipt_account_id"



  before_create :update_status
  private

 def update_status


    self.active = true
  end
end
