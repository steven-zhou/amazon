class ModifyFeedbackItem < ActiveRecord::Migration
  def self.up
    rename_column :feedback_items, :responsed_to_by_id, :responded_to_by_id
  end

  def self.down
    rename_column :feedback_items, :responded_to_by_id, :responsed_to_by_id
  end
end
