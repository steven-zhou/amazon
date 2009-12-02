class CreateAllocationTypes < ActiveRecord::Migration
  def self.up
    create_table :allocation_types do |t|

      t.column :name, :text
      t.column :description, :text
      t.column :link_module_id, :integer
      t.column :post_to_history, :boolean
      t.column :post_to_campaign, :boolean
      t.column :send_receipt, :boolean
      t.column :status, :boolean
      t.column :remarks, :text
      t.column :created_at, :datetime
      t.column :updated_at, :datetime

    end
  end

  def self.down
    drop_table :allocation_types
  end
end
