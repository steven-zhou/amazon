require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DuplicationFormulaDetailsController do
  before(:each) do
    @duplication_formula_detail = Factory(:duplication_formula_detail)
    @duplication_formula = @duplication_formula_detail.duplication_formula
  end
end
