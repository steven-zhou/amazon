class CreateLoginAccounts < ActiveRecord::Migration
  def self.up
    create_table :login_accounts do |t|
      t.column :person_id, :integer
      t.column :user_name, :text
      t.column :password_hash, :text
      t.column :password_salt, :text
      t.column :security_email, :text
      t.column :password_hint, :text
      t.column :security_question1, :text
      t.column :security_question2, :text
      t.column :security_question3, :text
      t.column :question1_answer, :text
      t.column :question2_answer, :text
      t.column :question3_answer, :text
      t.column :password_last_hash, :text
      t.column :password_last_salt, :text
      t.column :password_last_date, :date
      t.column :last_login, :datetime
      t.column :last_logoff, :datetime
      t.column :last_ip_address, :text
      t.column :session_timeout, :integer
      t.column :authentication_token, :text
      t.column :authentication_grace_period, :integer
      t.column :login_status, :boolean
      t.column :system_user, :boolean
    end
  end

  def self.down
    drop_table :login_accounts
  end
end
