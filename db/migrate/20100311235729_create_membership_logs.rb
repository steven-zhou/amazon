class CreateMembershipLogs < ActiveRecord::Migration
  def self.up
    create_table :membership_logs, :force => true do |t|
      t.integer :person_id
      t.integer :membership_id
      t.string :action
      t.integer :performer_id
      t.string :pre_status
      t.string :post_status
      t.text :comment
      t.date :performed_at
      t.integer :mail_template_id
      t.boolean :send_mail
      t.boolean :mail_sent
      t.integer :email_template_id
      t.boolean :send_email
      t.boolean :email_sent
      t.timestamps
    end
  end

  def self.down
    drop_table :membership_logs
  end
end
