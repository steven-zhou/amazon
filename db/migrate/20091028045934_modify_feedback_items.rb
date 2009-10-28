class ModifyFeedbackItems < ActiveRecord::Migration
  def self.up
    add_column :feedback_items, :response, :text
    add_column :feedback_items, :response_date, :datetime
    add_column :feedback_items, :responsed_to_by_id, :integer
  end

  def self.down
    remove_column :feedback_items, :response
    remove_column :feedback_items, :response_date
    remove_column :feedback_items, :responsed_to_by_id
  end
end
