class AddTypeToMessageTemplates < ActiveRecord::Migration
  def self.up
    add_column :message_templates, :type, :string
  end

  def self.down
    remove_column :message_templates, :type
  end
end
