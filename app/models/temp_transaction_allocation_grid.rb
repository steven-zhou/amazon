class TempTransactionAllocationGrid < Grid


   validates_presence_of  :field_1, :field_5
   belongs_to :receipt_account, :foreign_key => "field_1"
   belongs_to :campaign
   belongs_to :source




#  def self.all_temp_allocation(user)
#    temp_allocation = TempTransactionAllocationGrid.find_all_by_login_account_id(user)
#
#  end


end
