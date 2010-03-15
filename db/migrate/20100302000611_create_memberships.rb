class CreateMemberships < ActiveRecord::Migration
  def self.up
    create_table :memberships, :force => true do |t|
      t.integer "person_id"
      t.integer "employer_id"
      t.integer "workplace_id"
      t.integer "membership_status_id"
      t.integer "membership_type_id"
      t.integer "campaign_id"
      t.integer "source_id"
      t.date "starting_date"
      t.text "starting_comment"
      t.date "ending_date"
      t.text "ending_comment"
      t.integer "first_transaction_id"
      t.column :first_amount_paid, :decimal, :precision => 11, :scale => 3
      t.date "first_amount_date"
      t.integer "last_transaction_id"
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
