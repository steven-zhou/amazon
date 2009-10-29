class AddColumnsToClientSetups < ActiveRecord::Migration
  def self.up
    add_column :client_setups, :first_name, :string
    add_column :client_setups, :last_name, :string
    add_column :client_setups, :date_of_birth, :date
    add_column :client_setups, :primary_phone_number, :string
    add_column :client_setups, :secondary_phone_number, :string
    add_column :client_setups, :primary_email_address, :string
    add_column :client_setups, :secondary_email_address, :string
    add_column :client_setups, :login_account, :string
    add_column :client_setups, :first_name, :string
    add_column :client_setups, :primary_password_hash, :text
    add_column :client_setups, :primary_password_salt, :text
    add_column :client_setups, :secondary_password_hash, :text
    add_column :client_setups, :secondary_password_salt, :text
    add_column :client_setups, :security_question1_id, :integer
    add_column :client_setups, :security_question2_id, :integer
    add_column :client_setups, :security_question3_id, :integer
    add_column :client_setups, :question1_answer, :text
    add_column :client_setups, :question2_answer, :text
    add_column :client_setups, :question3_answer, :text
    add_column :client_setups, :last_login, :datetime
    add_column :client_setups, :last_logoff, :datetime
    add_column :client_setups, :last_ip_address, :text
  end

  def self.down
  end
end
