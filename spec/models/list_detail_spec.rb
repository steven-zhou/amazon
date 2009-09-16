
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ListDetail do

  it {should belong_to(:list_header)}
  it {should belong_to(:person)}
end

