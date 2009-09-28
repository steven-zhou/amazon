class DuplicationFormulaDetail < ActiveRecord::Base

  belongs_to :duplication_formula

  validates_uniqueness_of :field_name, :scope => :table_name

  def formatted_info
    "#{self.table_name}.#{self.field_name}(#{self.number_of_charecter})"
  end
end
