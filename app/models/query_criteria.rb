class QueryCriteria < ActiveRecord::Base

  OPERATORS = { "equals" => ["ILIKE", "", ""],
                "is greater than" => [">", "", ""],
                "likes" => ["ILIKE", "%", "%"],
                "starts with" => ["ILIKE", "", "%"],
                "ends with" => ["ILIKE", "%", ""],
  }
  
  belongs_to :query_header

  validates_presence_of :table_name, :field_name, :operator
  validates_uniqueness_of :field_name, :scope => [:query_header_id, :table_name, :operator]

  before_create :assign_sequence
  before_destroy :update_sequence

  def formatted_info
    result = (self.sequence == 1) ? "" : "#{self.option} "
    result += "#{self.table_name}.#{self.field_name} #{self.operator} #{self.value}"
  end

   def set_data_type(param1, param2)
     self.data_type = TableMetaType.find(:first, :conditions => ["name = ? AND tag_meta_type_id = ?", param1, TableMetaMetaType.find_by_name(param2)]).category
  end

  private
  def assign_sequence
    self.sequence = self.query_header.query_criterias.length+1
  end

  def update_sequence
    sequence = self.sequence
    QueryCriteria.transaction do
      self.query_header.query_criterias.each { |criteria|
        if (criteria.sequence > sequence)
          criteria.sequence -= 1
          criteria.save
        end
      }
    end
  end

 
end