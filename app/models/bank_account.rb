class BankAccount < ActiveRecord::Base
    belongs_to :bank
    validates_uniqueness_of :account_number, :scope => [:bank_id]
  
end
