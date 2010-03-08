class Membership < ActiveRecord::Base

  attr_accessor :stage
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

  validates_presence_of :person_id, :membership_status_id, :membership_type_id
  validates_presence_of :initiated_by, :initiated_date, :initiated_comment, :if => :initiate_stage?
  validates_presence_of :reviewed_by, :reviewed_date, :reviewed_comment, :if => :review_stage?
  validates_presence_of :finalized_by, :finalized_date, :finalized_comment, :if => :finalize_stage?

  def initiate_stage?
    stage == "InitiateStage"
  end

  def review_stage?
    stage == "ReviewStage"
  end

  def finalize_stage?
    stage == "FinalizeStage"
  end
end