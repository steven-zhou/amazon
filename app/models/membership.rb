class Membership < ActiveRecord::Base

  has_many :membership_fees, :class_name => "MembershipFee", :foreign_key => "membership_id"

  belongs_to :membership_status
  belongs_to :membership_type
  belongs_to :person
  belongs_to :employer, :class_name => "Organisation", :foreign_key => 'employer_id'
  belongs_to :workplace, :class_name => "Organisation", :foreign_key => 'workplace_id'

  
  belongs_to :source
  belongs_to :campaign
  belongs_to :initiator, :class_name => 'Person', :foreign_key => 'initiated_by'
  belongs_to :reviewer, :class_name => "Person", :foreign_key => 'reviewed_by'
  belongs_to :finalizer, :class_name => "Person", :foreign_key => ' finalized_by'
  belongs_to :next_reviewer, :class_name => "Person", :foreign_key => 'next_reviewed_by'
  belongs_to :suspender, :class_name => "Person", :foreign_key => 'suspended_by'
  belongs_to :terminator, :class_name => "Person", :foreign_key => 'terminated_by'

  belongs_to :transaction_header, :class_name => "TransactionHeader", :foreign_key => 'last_transaction_id'
 
end