class FeedbackItem < ActiveRecord::Base

  belongs_to :login_account

  validates_presence_of :login_account_id
  # validates_presence_of :subject
  # validates_presence_of :content

end
