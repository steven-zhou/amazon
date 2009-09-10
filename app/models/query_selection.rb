class QuerySelection < QueryDetail


  before_create :assign_sequence
  before_destroy :update_sequence

  def formatted_info
    "#{self.table_name}.#{self.field_name}"
  end

  private
  def assign_sequence
    self.sequence = self.query_header.query_selections.length+1
  end

  def update_sequence
    sequence = self.sequence
    QuerySelection.transaction do
      self.query_header.query_selections.each { |selection|
        if (selection.sequence > sequence)
          selection.sequence -= 1
          selection.save
        end
      }
    end
  end

end
