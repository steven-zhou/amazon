class DuplicationFormulaDetail < ActiveRecord::Base

  belongs_to :duplication_formula

  validates_uniqueness_of :field_name, :scope => :duplication_formula_id
  validates_presence_of :field_name, :number_of_charecter

  def formatted_info
    "#{self.table_name}.#{self.field_name}(#{self.number_of_charecter})"
  end
end
