class AddDescriptionFieldToMailTemplate < ActiveRecord::Migration
  def self.up
    add_column :message_templates, :description, :text
  end

  def self.down
    remove_column :message_templates, :description
  end
end
