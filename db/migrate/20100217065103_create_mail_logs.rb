class CreateMailLogs < ActiveRecord::Migration
  def self.up
    create_table :mail_logs do |t|
      t.integer :entity_id
      t.string :entity_type
      t.integer :doc_id
      t.string :channel
      t.timestamps
    end
  end

  def self.down
    drop_table :mail_logs
  end
end
