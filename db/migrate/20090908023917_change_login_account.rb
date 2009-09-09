class ChangeLoginAccount < ActiveRecord::Migration
  def self.up

    remove_column :login_accounts, :security_question1
    remove_column :login_accounts, :security_question2
    remove_column :login_accounts, :security_question3
    add_column :login_accounts, :security_question1_id, :integer
    add_column :login_accounts, :security_question2_id, :integer
    add_column :login_accounts, :security_question3_id, :integer
  end

  def self.down

    remove_column :login_accounts, :security_question1_id 
    remove_column :login_accounts, :security_question2_id 
    remove_column :login_accounts, :security_question3_id

     add_column :login_accounts, :security_question1, :text
    add_column :login_accounts, :security_question2, :text
    add_column :login_accounts, :security_question3, :text
  end
end
