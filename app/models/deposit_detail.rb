class DepositDetail < ActiveRecord::Base
  
  belongs_to :deposit

  validates_presence_of :deposit_id
end
