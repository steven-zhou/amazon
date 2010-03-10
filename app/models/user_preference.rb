class UserPreference < ActiveRecord::Base

  validates_presence_of :login_account_id
  belongs_to :login_account, :class_name => "LoginAccount", :foreign_key => "login_account_id"
  belongs_to :default_address_type, :class_name => "AmazonSetting", :foreign_key => "address_type_id"
  belongs_to :default_first_title, :class_name => "AmazonSetting", :foreign_key => "first_title_id"
  belongs_to :default_nationality, :class_name => "Country", :foreign_key => "first_title_id"
  belongs_to :default_language, :class_name => "AmazonSetting", :foreign_key => "language_id"
  belongs_to :default_phone_type, :class_name => "AmazonSetting", :foreign_key => "phone_type_id"
  belongs_to :default_email_type, :class_name => "AmazonSetting", :foreign_key => "email_type_id"
  belongs_to :default_website_type, :class_name => "AmazonSetting", :foreign_key => "website_type_id"
  belongs_to :default_note_type, :class_name => "AmazonSetting", :foreign_key => "note_type_id"




end
