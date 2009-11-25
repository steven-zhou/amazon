class CreateCampaignAndSource < ActiveRecord::Migration
  def self.up
    create_table :campaigns do |t|
      t.column :name, :text
      t.column :description, :text
      t.column :target_amount, :text
      t.column :start_date, :date
      t.column :end_date, :date
      t.column :status, :boolean
      t.column :remarks, :text
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end

    create_table :sources do |t|
      t.column :campaign_id, :integer
      t.column :name, :text
      t.column :description, :text
      t.column :volume, :integer
      t.column :cost, :text
      t.column :dead_return, :integer
      t.column :letter_id, :integer
      t.column :account_code_id, :integer
      t.column :status, :boolean
      t.column :remarks, :text
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end

  end

  def self.down
    drop_table :campaigns
    drop_table :sources
  end
end
