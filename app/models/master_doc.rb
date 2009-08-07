class MasterDoc < ActiveRecord::Base
  #acts_as_list :column => "priority_number"
  belongs_to :master_doc_type
  belongs_to :entity, :polymorphic => true
  validates_presence_of :master_doc_type_id

  belongs_to :issue_country, :class_name => "Country", :foreign_key => "issue_country_id"

  before_save :update_priority
  before_destroy :update_priority_before_destroy

  private
  def update_priority
    #self.move_to_bottom
    self.priority_number = self.entity.master_docs.length + 1 if self.new_record?
  end

  def update_priority_before_destroy
    priority_number = self.priority_number
    MasterDoc.transaction do
      self.entity.master_docs.each { |master_doc|
        if (master_doc.priority_number > priority_number)
          master_doc.priority_number -= 1
          master_doc.save!
        end
      }
    end
  end
end
