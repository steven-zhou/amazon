class MembershipFee < ActiveRecord::Base

  belongs_to :fee_item
  belongs_to :membership
  belongs_to :person, :through=>:membership

  belongs_to :payment_method_type
  belongs_to :receipt_account

  before_create :update_status
  
  private

 def update_status
    self.active = true
  end
end
