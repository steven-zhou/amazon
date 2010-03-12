class Membership < ActiveRecord::Base

  attr_accessor :stage
  has_many :membership_fees, :class_name => "MembershipFee", :foreign_key => "membership_id"

  belongs_to :membership_status
  belongs_to :membership_sub_status
  belongs_to :membership_type
  belongs_to :person
  belongs_to :employer, :class_name => "Organisation", :foreign_key => 'employer_id'
  belongs_to :workplace, :class_name => "Organisation", :foreign_key => 'workplace_id'

  
  belongs_to :source
  belongs_to :campaign
#  belongs_to :initiator, :class_name => 'Person', :foreign_key => 'initiated_by'
#  belongs_to :initiate_mail, :class_name => "PersonMailTemplate", :foreign_key => "initiate_mail_id"
#  belongs_to :initiate_email, :class_name => "PersonEmailTemplate", :foreign_key => "initiate_email_id"
#  belongs_to :reviewer, :class_name => "Person", :foreign_key => 'reviewed_by'
#  belongs_to :review_mail, :class_name => "PersonMailTemplate", :foreign_key => "review_mail_id"
#  belongs_to :review_email, :class_name => "PersonEmailTemplate", :foreign_key => "review_email_id"
#  belongs_to :second_reviewer, :class_name => "Person", :foreign_key => 'second_reviewed_by'
#  belongs_to :second_review_mail, :class_name => "PersonMailTemplate", :foreign_key => "second_review_mail_id"
#  belongs_to :second_review_email, :class_name => "PersonEmailTemplate", :foreign_key => "second_review_email_id"
#  belongs_to :third_reviewer, :class_name => "Person", :foreign_key => 'third_reviewed_by'
#  belongs_to :third_review_mail, :class_name => "PersonMailTemplate", :foreign_key => "third_review_mail_id"
#  belongs_to :third_review_email, :class_name => "PersonEmailTemplate", :foreign_key => "third_review_email_id"
#  belongs_to :finalizer, :class_name => "Person", :foreign_key => ' finalized_by'
#  belongs_to :approve_mail, :class_name => "PersonMailTemplate", :foreign_key => "approve_mail_id"
#  belongs_to :approve_email, :class_name => "PersonEmailTemplate", :foreign_key => "approve_email_id"
#  belongs_to :decline_mail, :class_name => "PersonMailTemplate", :foreign_key => "decline_mail_id"
#  belongs_to :decline_email, :class_name => "PersonEmailTemplate", :foreign_key => "decline_email_id"
#  belongs_to :next_reviewer, :class_name => "Person", :foreign_key => 'next_reviewed_by'
#  belongs_to :suspender, :class_name => "Person", :foreign_key => 'suspended_by'
#  belongs_to :terminator, :class_name => "Person", :foreign_key => 'terminated_by'
  belongs_to :transaction_header, :class_name => "TransactionHeader", :foreign_key => 'last_transaction_id'

  validates_presence_of :person_id, :membership_sub_status_id, :membership_type_id
  validates_uniqueness_of :person_id
  
#  validates_presence_of :initiated_by, :initiated_date, :initiated_comment, :if => :initiate_stage?
#  validates_format_of :initiated_date, :with => /^(((0[1-9]|[12]\d|3[01])\-(0[13578]|1[02])\-((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)\-(0[13456789]|1[012])\-((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])\-02\-((19|[2-9]\d)\d{2}))|(29\-02\-((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$/, :if => :initiate_stage?
#  validates_presence_of :reviewed_by, :reviewed_date, :reviewed_comment, :if => :review_stage?
#  validates_format_of :reviewed_date, :with => /^(((0[1-9]|[12]\d|3[01])\-(0[13578]|1[02])\-((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)\-(0[13456789]|1[012])\-((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])\-02\-((19|[2-9]\d)\d{2}))|(29\-02\-((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$/, :if => :review_stage?
#  validates_presence_of :finalized_by, :finalized_date, :finalized_comment, :if => :finalize_stage?
#  validates_format_of :finalized_date, :with => /^(((0[1-9]|[12]\d|3[01])\-(0[13578]|1[02])\-((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)\-(0[13456789]|1[012])\-((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])\-02\-((19|[2-9]\d)\d{2}))|(29\-02\-((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$/, :if => :finalize_stage?
#  

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