class DuplicationFormula < ActiveRecord::Base

  has_many :duplication_formula_details

  def formatted_info
    result = Array.new
    self.duplication_formula_details.each do |i|
      result << i.formatted_info
    end
    result.join(" - ")
  end
end
