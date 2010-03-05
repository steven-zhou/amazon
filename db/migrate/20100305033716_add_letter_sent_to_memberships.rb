class AddLetterSentToMemberships < ActiveRecord::Migration
  def self.up
    rename_column :memberships, :letter_id, :initiate_letter_id
    add_column :memberships, :review_letter_id, :string
    add_column :memberships, :approve_letter_id, :string
    add_column :memberships, :suspend_letter_id, :string
    add_column :memberships, :terminate_letter_id, :string
    add_column :memberships, :initiate_letter_sent, :boolean
    add_column :memberships, :review_letter_sent, :boolean
    add_column :memberships, :approve_letter_sent, :boolean
    add_column :memberships, :suspend_letter_sent, :boolean
    add_column :memberships, :terminate_letter_sent, :boolean
  end

  def self.down
    rename_column :memberships, :initiate_letter_id, :letter_id
    remove_column :memberships, :review_letter_id
    remove_column :memberships, :approve_letter_id
    remove_column :memberships, :suspend_letter_id
    remove_column :memberships, :terminate_letter_id
    remove_column :memberships, :initiate_letter_sent
    remove_column :memberships, :review_letter_sent
    remove_column :memberships, :approve_letter_sent
    remove_column :memberships, :suspend_letter_sent
    remove_column :memberships, :terminate_letter_sent
  end
end
