class MessageTemplate < ActiveRecord::Migration
  def self.up
    create_table :message_templates do |t|
      t.column :name, :text
      t.column :body, :text
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end

  end

  def self.down

    drop_table :message_templates

  end
end
