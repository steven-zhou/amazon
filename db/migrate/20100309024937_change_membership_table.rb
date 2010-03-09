class ChangeMembershipTable < ActiveRecord::Migration
  def self.up
   rename_column :memberships, :initiate_letter_id,:initiate_mail_id
   add_column :memberships, :initiate_email_id, :integer

   rename_column :memberships, :review_letter_id,:review_mail_id
   add_column :memberships, :review_email_id, :integer

   rename_column :memberships, :approve_letter_id,:approve_mail_id
   add_column :memberships, :approve_email_id, :integer

  end

  def self.down
    rename_column :memberships, :initiate_mail_id,:initiate_letter_id
    remove_column :memberships, :initiate_email_id

    rename_column :memberships, :review_mail_id,:review_letter_id
    remove_column :memberships, :review_email_id

    rename_column :memberships, :approve_mail_id,:approve_letter_id
    remove_column :memberships, :approve_email_id
  end
end
