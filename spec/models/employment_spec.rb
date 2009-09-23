require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Employment do

  before(:each) do
    @primary_list = Factory(:primary_list)
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

    it "should not save when emp_supervisor is not blank but invalid" do
      @employment = Factory.build(:employment)
      @employment.report_to = "-1"
      @employment.save.should == false
      @employment.errors.on(:report_to).should_not be_nil
    end

    it "should not save when emp_terminator is not blank but invalid" do
      @employment = Factory.build(:employment)
      @employment.terminated_by = "-1"
      @employment.save.should == false
      @employment.errors.on(:terminated_by).should_not be_nil
    end

    it "should not save when emp_suspensor is not blank but invalid" do
      @employment = Factory.build(:employment)
      @employment.suspended_by = "-1"
      @employment.save.should == false
      @employment.errors.on(:suspended_by).should_not be_nil
    end
  end


  describe "When creating or updating a valid record" do
    it "should add the new record to the bottom of the record list" do
      @job_one = Factory.build(:employment)
      @person = @job_one.employee
      @person.employments << @job_one
      @job_one.save

      @job_two = Factory.build(:employment, :employee => @person)
      @person.employments << @job_two
      @job_two.save

      @job_three = Factory.build(:employment, :employee => @person)
      @person.employments << @job_three
      @job_three.save

      @job_one.sequence_no.should == 1
      @job_two.sequence_no.should == 2
      @job_three.sequence_no.should == 3

    end

    it "should add the editing record to the bottom of ther record list if it is changed to be inactive" do
      @job_one = Factory.build(:employment)
      @person = @job_one.employee
      @person.employments << @job_one
      @job_one.save

      @job_two = Factory.build(:employment, :employee => @person)
      @person.employments << @job_two
      @job_two.save

      @job_three = Factory.build(:employment, :employee => @person)
      @person.employments << @job_three
      @job_three.save

      @job_two.status = false
      @job_two.save

      @job_one.sequence_no.should == 1
      @job_two.sequence_no.should == 3
      @job_three.sequence_no.should == 2

      @job_one.status = false
      @job_one.save
      @job_one.sequence_no.should == 3
      @job_two.sequence_no.should == 2
      @job_three.sequence_no.should == 1
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