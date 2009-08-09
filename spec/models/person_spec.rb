require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Person do
  before(:each) do
    @attributes = Factory.attributes_for(:john)
    @person = Factory.build(:john)
  end
  
  it { should validate_presence_of(:family_name)}
  it { should have_many(:addresses)}
  it { should have_many(:phones)}
  it { should have_many(:master_docs)}
  it { should have_many(:keywords, :through => :keyword_links,:uniq => true)}
  it { should have_many(:roles, :through => :person_roles, :uniq => true)}
  it { should belong_to(:primary_title)}
  it { should belong_to(:second_title)}
  it { should belong_to(:language)}
  it { should belong_to(:religion)}
  it { should belong_to(:other_language)}
  it { should belong_to(:origin_country)}
  it { should belong_to(:residence_country)}
  it { should belong_to(:nationality)}
  it { should have_many(:person_roles)}
  it { should have_many(:organisation_key_personnels)}
  it { should have_many(:employments, :class_name => 'Employment', :foreign_key => 'person_id')}
  it { should have_many(:emp_recruitments, :class_name => 'Employment', :foreign_key => 'hired_by')}
  it { should have_many(:emp_supervisions, :class_name => 'Employment', :foreign_key => 'report_to')}
  it { should have_many(:emp_terminations, :class_name => 'Employment', :foreign_key => 'terminated_by')}
  it { should have_many(:emp_suspensions, :class_name => 'Employment', :foreign_key => 'suspended_by')}
  it { should have_many(:emp_recruiters, :through => :employments, :source => :emp_recruiter)}
  it { should have_many(:emp_supervisors, :through => :employments, :source => :emp_supervisor)}
  it { should have_many(:emp_terminators, :through => :employments, :source => :emp_terminator)}
  it { should have_many(:emp_suspenders, :through => :employments, :source => :emp_suspender)}
  it { should have_many(:employers, :through => :employments, :source => :organisation)}

  it { should have_many(:person_roles, :class_name => 'PersonRole', :foreign_key => 'person_id')}
  it { should have_many(:assign_roles, :class_name => 'PersonRole', :foreign_key => 'assigned_by')}
  it { should have_many(:approve_roles, :class_name => 'PersonRole', :foreign_key => 'approved_by')}
  it { should have_many(:supervise_roles, :class_name => 'PersonRole', :foreign_key => 'supervised_by')}
  it { should have_many(:manage_roles, :class_name => 'PersonRole', :foreign_key => 'managed_by')}

  it { should have_many(:role_players, :through => :person_roles, :source => :role_player)}
  it { should have_many(:role_assigners, :through => :person_roles, :source => :role_assigner)}
  it { should have_many(:role_approvers, :through => :person_roles, :source => :role_approver)}
  it { should have_many(:role_supervisers, :through => :person_roles, :source => :role_superviser)}
  it { should have_many(:role_managers, :through => :person_roles, :source => :role_manager)}

  
  context "when saving" do
  
    context "and no formal salutation exists" do 
      
      before(:each) do
        @title = Factory.build(:mr)
        @person.primary_salutation = ""
      end
  
      it "should insert the title, first name and family name if salutation is blank" do
        @person.save
        @person.primary_salutation.should == "#{@person.primary_title.name} #{@person.first_name} #{@person.family_name}"
      end
    
      it "should insert only the title and family name into formal salutation" do
        @person.first_name = ""
        @person.save
        @person.primary_salutation.should == "#{@person.primary_title.name} #{@person.family_name}"
      end
      
    end #end context
  
    context "and a formal salutation exists" do 
      it "should not insert a salutation" do
        @person.primary_salutation.should == @attributes[:primary_salutation]
      end
    end #end context
     
  end #end when saving context

  context "getter" do
    it "should return full name" do
      @person.name.should == "#{@person.first_name} #{@person.family_name}"
    end

    it "should return full name and title" do
      @person.full_name_and_title.should == "#{@person.primary_title.name} #{@person.first_name} #{@person.family_name}"
    end

    it "should return the first name and last name" do
      @person.primary_title = nil
      @person.full_name_and_title.should == "#{@person.first_name} #{@person.family_name}"
    end

    it "should return the title and last name" do
      @person.first_name = nil
      @person.full_name_and_title.should == "#{@person.primary_title.name} #{@person.family_name}"
    end

#    it "should return the title name" do
#      @person.title_name.should == @person.primary_title.name
#    end

    it "should return the second title name" do
      @person.second_title_name.should == @person.second_title.name
    end

#    it "should return the priority address" do
#
#      @address = Factory.build(:address)
#      @person.addresses<<@address
#      @person.addresses.should_receive(:find_by_priority).with(1).and_return(@person)
#      @person.primary_address.should_not be_nil
#    end
#
#    it "should return the priority email" do
#      @email = Factory.build(:email)
#      @person.emails<<@email
#      @person.emails.stub!(:find_by_priority).with(true).and_return(@email)
#      @person.primary_email.should_not be_nil
#    end
#
#    it "should return the priority phone" do
#      @phone = Factory.build(:phone)
#      @person.phones<<@phone
#      @person.phones.should_receive(:find_by_priority).with(false).and_return(@phone)
#      @person.primary_phone.should_not be_nil
#    end

    it "should return 18 for if birthday is 18.years.ago" do
      @person.birth_date = 18.years.ago
      @person.age.should == 18
    end
  end
end