class AddMailmergecategoryIdToMessagetemplate < ActiveRecord::Migration
  def self.up
    add_column :message_templates, :mail_merge_category_id, :integer
  end

  def self.down
    remove_column :message_templates, :mail_merge_category_id
  end
end
