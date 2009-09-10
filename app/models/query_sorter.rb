class QuerySorter < QueryDetail

  before_create :assign_sequence
  before_destroy :update_sequence

  def formatted_info
    "#{self.table_name}.#{self.field_name}"
  end

  private
  def assign_sequence
    self.sequence = self.query_header.query_sorters.length+1
  end

  def update_sequence
    sequence = self.sequence
    QuerySorter.transaction do
    self.query_header.query_sorters.each { |sorter|
        if (sorter.sequence > sequence)
          sorter.sequence -= 1
          sorter.save
        end
      }
    end
  end
end
