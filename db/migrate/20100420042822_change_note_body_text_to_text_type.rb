class ChangeNoteBodyTextToTextType < ActiveRecord::Migration
  def self.up
    change_column :notes, :body_text, :text
  end

  def self.down
    change_column :notes, :body_text, :string
  end
end
