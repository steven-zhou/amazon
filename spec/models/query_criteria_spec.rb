require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe QueryCriteria do

  it { should belong_to(:query_header)}

#  it "should validates the uniqueness of table_name+field_name" do
#    @query_criteria1 = QueryCriteria.new(:table_name => "People", :field_name => "family_name", :operator => "equals", :value => "Smith")
#    @query_header = Factory.build(:query_header)
#    @query_criteria1.query_header = @query_header
#    @query_header.query_criterias << @query_criteria1
#    puts "-- #{@query_header.query_criterias.to_yaml} --"
#    @query_criteria1.save.should == true
#
#    @query_criteria2 = QueryCriteria.new(:table_name => "Addresses", :field_name => "state", :operator => "equals", :value => "NSW")
#    @query_criteria2.query_header = @query_header
#    @query_header.query_criterias << @query_criteria2
#    @query_criteria2.save.should == true
#
#    @query_criteria3 = QueryCriteria.new(:table_name => "Addresses", :field_name => "state", :operator => "equals", :value => "NSW")
#    @query_criteria3.query_header = @query_header
#    @query_header.query_criterias << @query_criteria3
#    @query_criteria3.save.should == false
#
#
#  end

  describe "update sequence when call back" do

    it "should update sequence when saving" do
      @query_criteria1 = QueryCriteria.new(:table_name => "People", :field_name => "family_name", :operator => "equals", :value => "Smith")
      @query_header = Factory(:query_header)
      @query_criteria1.query_header = @query_header
#      @query_header.query_criterias << @query_criteria1

      puts "** #{@query_criteria1.to_yaml}"
      puts "-- #{@query_header.to_yaml}"
      
      #@query_criteria1.save
      @query_criteria1.sequence.should == 1

#      @query_criteria2 = QueryCriteria.new(:table_name => "Addresses", :field_name => "state", :operator => "equals", :value => "NSW")
#      @query_criteria2.query_header = @query_header
#      @query_header.query_criterias << @query_criteria2
#      @query_criteria2.save
#      @query_criteria2.sequence.should == 2
#
#      @query_criteria1.destroy
#      @query_criteria2.sequence.should == 1
      end
  end
end
