class CreateMemberships < ActiveRecord::Migration
  def self.up
    create_table :memberships do |t|
      t.integer "person_id"
      t.integer "employer_id"
      t.integer "workplace_id"
      t.integer "membership_status_id"
      t.integer "membership_type_id"
      t.integer "campaign_id"
      t.integer "source_id"
      t.integer "last_transaction_id"
      t.integer "letter_id"

      t.integer "initiated_by"
      t.date "initiated_date"
      t.text "initiated_comment"
      t.integer "reviewed_by"
      t.date "reviewed_date"
      t.text "reviewed_comment"
      t.integer "next_reviewed_by"
      t.date "next_reviewed_date"
      t.text "next_reviewed_comment"
      t.integer "finalized_by"
      t.date "finalized_date"
      t.text "finalized_comment"

      t.date "starting_date"
      t.text "starting_comment"

      t.date "ending_date"
      t.text "ending_comment"

      t.integer "suspended_by"
      t.date "suspended_date"
      t.text "suspended_comment"

      t.integer "terminated_by"
      t.date "terminated_date"
      t.text "terminated_comment"

      t.column :last_amount_paid, :decimal, :precision => 11, :scale => 3
      t.date "last_amount_date"
      t.column :YTD_total, :decimal, :precision => 11, :scale => 3
      
      t.integer "creator_id"
      t.integer "updater_id"
      t.boolean "active"
      t.timestamps
    end
  end

  def self.down
    drop_table :memberships
  end
end
