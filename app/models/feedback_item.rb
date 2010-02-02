class FeedbackItem < ActiveRecord::Base

  belongs_to :login_account
  belongs_to :responder, :class_name => "LoginAccount", :foreign_key => "responded_to_by_id"

  validates_presence_of :login_account_id
  # validates_presence_of :subject
  # validates_presence_of :content
  default_scope :order => "created_at DESC"

  def submitted_by
  (self.login_account.class.to_s == "SystemUser")?  self.login_account.person.name : self.login_account.user_name
  end



end
