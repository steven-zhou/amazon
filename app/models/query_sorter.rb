class QuerySorter < QueryDetail

  validates_uniqueness_of :field_name, :scope => [:query_header_id, :table_name]
  
  before_create :assign_sequence
  before_destroy :update_sequence

  def formatted_info
    if self.ascending
      "#{self.table_name}.#{self.field_name} ASC"
    else
      "#{self.table_name}.#{self.field_name} DES"
    end
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
