require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe QueryDetail do
  before(:each) do
    @primary_list = Factory(:primary_list)
  end

  it { should belong_to(:query_header)}

  describe "update sequence when call back" do

    it "should update sequence when saving" do
      @query_selection1 = QuerySelection.new(:table_name => "People", :field_name => "family_name")
      @query_header = Factory(:query_header)
      @query_selection1.query_header = @query_header
      @query_header.query_selections << @query_selection1
      @query_selection1.save
      @query_selection1.sequence.should == 1

      @query_selection2 = QuerySelection.new(:table_name => "Addresses", :field_name => "state")
      @query_selection2.query_header = @query_header
      @query_header.query_selections << @query_selection2
      @query_selection2.save
      @query_selection2.sequence.should == 2

      @query_selection1.destroy
      @query_selection2.sequence.should == 1
      end
  end

  it "should validates the uniqueness of table_name+field_name" do
    @query_selection1 = QuerySelection.new(:table_name => "People", :field_name => "family_name")
    @query_header = Factory.build(:query_header)
    @query_selection1.query_header = @query_header
    @query_header.query_selections << @query_selection1
    @query_selection1.save.should == true

    @query_selection2 = QuerySelection.new(:table_name => "Addresses", :field_name => "state")
    @query_selection2.query_header = @query_header
    @query_header.query_selections << @query_selection2
    @query_selection2.save.should == true

    @query_selection3 = QuerySelection.new(:table_name => "Addresses", :field_name => "state")
    @query_selection3.query_header = @query_header
    @query_header.query_selections << @query_selection3
    @query_selection3.save.should == false

    @query_selection4 = QuerySelection.new(:table_name => "People", :field_name => "state")
    @query_selection4.query_header = @query_header
    @query_header.query_selections << @query_selection4
    @query_selection4.save.should == true

    @query_selection5 = QuerySelection.new(:table_name => "Addresses", :field_name => "state")
    @query_header2 = Factory.build(:query_header)
    @query_selection5.query_header = @query_header2
    @query_header2.query_selections << @query_selection5
    @query_selection5.save.should == true
  end
end
