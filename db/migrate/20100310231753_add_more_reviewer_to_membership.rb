class AddMoreReviewerToMembership < ActiveRecord::Migration
  def self.up
    add_column :memberships, :decline_mail_id, :integer
    add_column :memberships, :decline_email_id, :integer
    add_column :memberships, :decline_letter_sent, :boolean
    add_column :memberships, :second_reviewed_by, :integer
    add_column :memberships, :second_reviewed_date, :date
    add_column :memberships, :second_reviewed_comment, :text
    add_column :memberships, :second_reviewed_mail_id, :integer
    add_column :memberships, :second_reviewed_email_id, :integer
    add_column :memberships, :second_reviewed_letter_sent, :boolean
    add_column :memberships, :third_reviewed_by, :integer
    add_column :memberships, :third_reviewed_date, :date
    add_column :memberships, :third_reviewed_comment, :text
    add_column :memberships, :third_reviewed_mail_id, :integer
    add_column :memberships, :third_reviewed_email_id, :integer
    add_column :memberships, :third_reviewed_letter_sent, :boolean
    add_column :memberships, :billing, :boolean
  end

  def self.down
    remove_column :memberships, :decline_mail_id
    remove_column :memberships, :decline_email_id
    remove_column :memberships, :decline_letter_sent
    remove_column :memberships, :second_reviewed_by
    remove_column :memberships, :second_reviewed_date
    remove_column :memberships, :second_reviewed_comment
    remove_column :memberships, :second_reviewed_mail_id
    remove_column :memberships, :second_reviewed_email_id
    remove_column :memberships, :second_reviewed_letter_sent
    remove_column :memberships, :third_reviewed_by
    remove_column :memberships, :third_reviewed_date
    remove_column :memberships, :third_reviewed_comment
    remove_column :memberships, :third_reviewed_mail_id
    remove_column :memberships, :third_reviewed_email_id
    remove_column :memberships, :third_reviewed_letter_sent
    remove_column :memberships, :billing
  end
end
