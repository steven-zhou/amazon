require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DuplicationFormulaDetail do
  it { should belong_to(:duplication_formula)}
end
