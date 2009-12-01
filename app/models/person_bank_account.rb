class PersonBankAccount < ActiveRecord::Base

  belongs_to :person
  belongs_to :bank
  belongs_to :account_type
  validates_uniqueness_of :account_number, :scope => [:bank_id]


end
