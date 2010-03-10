class ChangeMailergercategoryidtoTemplateCategoryId < ActiveRecord::Migration
  def self.up
        rename_column :message_templates, :mail_merge_category_id, :template_category_id
  end

  def self.down
        rename_column :message_templates, :template_category_id, :mail_merge_category_id
  end
end
