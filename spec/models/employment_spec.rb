require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Employment do

  before(:each) do
    @attributes = Factory.attributes_for(:employment)
    @employment = Factory.build(:employment)
  end


  it { should belong_to(:organisation) }
  it { should belong_to(:employee, :class_name => 'Person', :foreign_key => 'person_id')}
  it { should belong_to(:emp_recruiter, :class_name => 'Person', :foreign_key => 'hired_by')}
  it { should belong_to(:emp_supervisor, :class_name => 'Person', :foreign_key => 'report_to')}
  it { should belong_to(:emp_terminator, :class_name => 'Person', :foreign_key => 'terminated_by')}
  it { should belong_to(:emp_suspender, :class_name => 'Person', :foreign_key => 'suspended_by')}
  it { should belong_to(:department)}
  it { should belong_to(:section)}
  it { should belong_to(:cost_centre)}
  it { should belong_to(:position_title)}
  it { should belong_to(:position_classification)}
  it { should belong_to(:position_type)}
  it { should belong_to(:award_agreement)}
  it { should belong_to(:position_status)}
  it { should belong_to(:payment_frequency)}
  it { should belong_to(:payment_method)}
  it { should belong_to(:payment_day)}
  it { should belong_to(:suspension_type)}
  it { should belong_to(:termination_method)}

  describe "When validating the model" do
    it "should save when it is valid" do
      @employment = Factory.build(:employment)
      @employment.save.should == true
    end

    it "should not save when organisation id is blank" do
      @employment = Factory.build(:employment, :organisation_id => "")
      @employment.save.should == false
      @employment.errors.on(:organisation).should_not be_nil
    end

    it "should not save when organisation is invalid" do
      @employment = Factory.build(:employment, :organisation_id => "-1")
      @employment.save.should == false
      @employment.errors.on(:organisation).should_not be_nil
    end

    it "should not save when supervisor is not blank but invalid" do
      @employment = Factory.build(:employment, :report_to => "-1")
      @employment.save.should == false
      @employment.errors.on(:emp_supervisor).should_not be_nil
    end
  end


  describe "When creating or updating a valid record" do
    it "should add the new record to the bottom of the record list" do
#      Employment.destroy_all
#      @person = Factory(:john)
#      puts " %% #{@person.id} %%"
#      @employment1 = Factory(:employment, :employee => @person)
#      @employment2 = Factory(:employment, :employee => @person)
#      puts "-- Person saved = #{!@person.new_record?}"
#      puts "-- Employment 1 saved = #{!@employment1.new_record?}"
#      puts "-- Employment 2 saved = #{!@employment2.new_record?}"
#      puts "** DEBUG ** #{@person.employments.to_yaml}"
#      Employment.find_by_id(@employment1.id).sequence_no.should == 1
#      Employment.find_by_id(@employment2.id).sequence_no.should == 2
    end

    it "should calculate salary correctly" do
      @employment = Factory(:employment)
      @employment.annual_base_salary.should == @employment.weekly_nominal_hours * @employment.hourly_rate * 52
    end

    it "should re-calculate salary" do
      @employment = Factory(:employment)
      original_salary = @employment.annual_base_salary
      @employment.weekly_nominal_hours += 10
      @employment.save
      new_salary = @employment.annual_base_salary
      original_salary.should_not == new_salary
    end


  end


end