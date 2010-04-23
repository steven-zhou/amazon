class UserPreference < ActiveRecord::Base

  validates_presence_of :login_account_id
  belongs_to :login_account, :class_name => "LoginAccount", :foreign_key => "login_account_id"
  belongs_to :default_list_header, :class_name => "ListHeader", :foreign_key => "default_list_header_id"
  belongs_to :default_address_type, :class_name => "AmazonSetting", :foreign_key => "default_address_type_id"
  belongs_to :default_first_title, :class_name => "AmazonSetting", :foreign_key => "default_first_title_id"
  belongs_to :default_nationality, :class_name => "Country", :foreign_key => "default_nationality_id"
  belongs_to :default_language, :class_name => "AmazonSetting", :foreign_key => "default_language_id"
  belongs_to :default_phone_type, :class_name => "AmazonSetting", :foreign_key => "default_phone_type_id"
  belongs_to :default_email_type, :class_name => "AmazonSetting", :foreign_key => "default_email_type_id"
  belongs_to :default_website_type, :class_name => "AmazonSetting", :foreign_key => "default_website_type_id"
  belongs_to :default_note_type, :class_name => "AmazonSetting", :foreign_key => "default_note_type_id"

end
