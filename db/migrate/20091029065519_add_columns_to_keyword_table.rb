class AddColumnsToKeywordTable < ActiveRecord::Migration
  def self.up
    add_column :keywords, :status, :boolean
    remove_column :keywords, :remarks
    add_column :keywords, :description, :string
  end

  def self.down
    remove_column :keywords, :status
    add_column :keywords, :remarks, :string
    remove_column :keywords, :description
  end
end