class AddSubmittedByToFeedback < ActiveRecord::Migration
  def self.up
    add_column :feedback_items, :submitted_by, :string
  end

  def self.down
    remove_column :feedback_items, :submitted_by
  end
end
