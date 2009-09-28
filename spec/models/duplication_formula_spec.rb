require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DuplicationFormula do
  it { should have_many(:duplication_formula_details)}
end
