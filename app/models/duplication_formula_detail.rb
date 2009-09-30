class DuplicationFormulaDetail < ActiveRecord::Base

  belongs_to :duplication_formula

  validates_uniqueness_of :field_name, :scope => :duplication_formula_id

  def formatted_info
    "#{self.table_name}.#{self.field_name}(#{self.number_of_charecter})"
  end
end
