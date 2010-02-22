class NightlyProcessesController < ApplicationController
  # for testing only

  def index

    respond_to do |format|
      format.html
    end
  end

  def run
    destroy_amazon_setting
    destroy_tag
    destroy_receipting
    destroy_people
    destroy_organisation
    respond_to do |format|
      format.js
    end
  end

  private
  
  
  def destroy_people
    
    puts "Destroy People"



    primary_list = PrimaryList.first.list_details
    person_list_headers = PersonListHeader.all

    Person.find(:all,:conditions=>["to_be_removed = true"]).each do |person|

      person_list_headers.try(:each) do |person_list_header|
        person_on_list = person_list_header.list_details.find_by_entity_id(person.id)
        puts "Destroy People on list"
        person_on_list.destroy unless person_on_list.nil?
      end

      list_detail = primary_list.find_by_entity_id(person.id)
      #      puts "*************************"
      #      puts person.id
      #      puts list_detail
      puts "Destroy People on Primary List Detail"
      list_detail.destroy unless list_detail.nil?

      #      puts "Destroy People Relationship"
      #
      #        source_person = Relationship.find_all_by_source_person_id(person.id)
      #        source_person.each do |i|
      #        i.destroy unless i.nil?
      #        end
      #
      #        relate_person = Relationship.find_all_by_related_person_id(person.id)
      #         relate_person.each do |j|
      #           j.destroy unless j.nil?
      #        end



      person.destroy

 
    end
    
  end

  def destroy_organisation
        
    puts "Destroy Organisation"
    org_primary_list = OrganisationPrimaryList.first.list_details
    org_list_headers = OrganisationListHeader.all

    Organisation.find(:all,:conditions=>["to_be_removed = true"]).each do |org|

        org_list_headers.try(:each) do |org_list_header|
        org_on_list = org_list_header.list_details.find_by_entity_id(org.id)
        puts "Destroy Organisation on list"
        org_on_list.destroy unless org_on_list.nil?
      end

      org_list_detail = org_primary_list.find_by_entity_id(org.id)

      puts "Destroy Org on Primary List Detail"
      org_list_detail.destroy unless org_list_detail.nil?

      org.destroy
    end
    
  end

  def destroy_amazon_setting



    puts "Destroy Account Purpose"
    AccountPurpose.find(:all,:conditions=>["to_be_removed = true"]).each do |i|

      unless BankAccount.find_by_account_purpose_id(i.id).nil?
        i.to_be_removed = false
        i.save
      else
        i.destroy
      end
    end



    puts "Destroy Account Type"
    AccountType.find(:all,:conditions=>["to_be_removed = true"]).each do |i|

      unless BankAccount.find_by_account_type_id(i.id).nil?
        i.to_be_removed = false
        i.save
      else
        i.destroy
      end
    end


    puts "Destroy Title"
    Title.find(:all,:conditions=>["to_be_removed = true"]).each do |i|

      unless (Person.find_by_primary_title_id(i.id).nil?  and Person.find_by_second_title_id(i.id).nil?)
        i.to_be_removed = false
        i.save
      else
        i.destroy
      end
    end

    puts "Destroy Gender"
    Gender.find(:all,:conditions=>["to_be_removed = true"]).each do |i|

      unless Person.find_by_gender_id(i.id).nil?
        i.to_be_removed = false
        i.save
      else
        i.destroy
      end
    end

    puts "Destroy IndustrySector"
    IndustrySector.find(:all,:conditions=>["to_be_removed = true"]).each do |i|

      unless Organisation.find_by_industry_sector_id(i.id).nil?
        i.to_be_removed = false
        i.save
      else
        i.destroy
      end
    end


    puts "Destroy Address Type"
    AddressType.find(:all,:conditions=>["to_be_removed = true"]).each do |i|

      unless Address.find_by_address_type_id(i.id).nil?
        i.to_be_removed = false
        i.save
      else
        i.destroy
      end
    end

    puts "Destroy Note Type"
    NoteType.find(:all,:conditions=>["to_be_removed = true"]).each do |i|

      unless Note.find_by_note_type_id(i.id).nil?
        i.to_be_removed = false
        i.save
      else
        i.destroy
      end
    end

    puts "Destroy Marital Status"
    MaritalStatus.find(:all,:conditions=>["to_be_removed = true"]).each do |i|

      unless Person.find_by_marital_status_id(i.id).nil?
        i.to_be_removed = false
        i.save
      else
        i.destroy
      end
    end

    puts "Destroy Department"
    Department.find(:all,:conditions=>["to_be_removed = true"]).each do |i|

      unless Employment.find_by_department_id(i.id).nil?
        i.to_be_removed = false
        i.save
      else
        i.destroy
      end
    end

    puts "Destroy Section"
    Section.find(:all,:conditions=>["to_be_removed = true"]).each do |i|

      unless Employment.find_by_section_id(i.id).nil?
        i.to_be_removed = false
        i.save
      else
        i.destroy
      end
    end

    puts "Destroy Cost Centre"
    CostCentre.find(:all,:conditions=>["to_be_removed = true"]).each do |i|

      unless Employment.find_by_cost_centre_id(i.id).nil?
        i.to_be_removed = false
        i.save
      else
        i.destroy
      end
    end


    puts "Destroy Position Type"
    PositionTitle.find(:all,:conditions=>["to_be_removed = true"]).each do |i|

      unless Employment.find_by_position_title_id(i.id).nil?
        i.to_be_removed = false
        i.save
      else
        i.destroy
      end
    end

    puts "Destroy Position Classification"
    PositionClassification.find(:all,:conditions=>["to_be_removed = true"]).each do |i|

      unless Employment.find_by_position_classification_id(i.id).nil?
        i.to_be_removed = false
        i.save
      else
        i.destroy
      end
    end


    puts "Destroy Position Type"
    PositionType.find(:all,:conditions=>["to_be_removed = true"]).each do |i|

      unless Employment.find_by_position_type_id(i.id).nil?
        i.to_be_removed = false
        i.save
      else
        i.destroy
      end
    end

    puts "Destroy Award Agreement"
    AwardAgreement.find(:all,:conditions=>["to_be_removed = true"]).each do |i|

      unless Employment.find_by_position_type_id(i.id).nil?
        i.to_be_removed = false
        i.save
      else
        i.destroy
      end
    end


    puts "Destroy Postition Status"
    PositionStatus.find(:all,:conditions=>["to_be_removed = true"]).each do |i|

      unless Employment.find_by_position_type_id(i.id).nil?
        i.to_be_removed = false
        i.save
      else
        i.destroy
      end
    end

    puts "destroy payment frequency"
    PaymentFrequency.find(:all,:conditions => ["to_be_removed = true"]).each do |i|
      unless Employment.find_by_payment_frequency_id(i.id).nil?
        i.to_be_removed = false
        i.save
      else
        i.destroy
      end
    end

    puts "destroy payment method"
    PaymentMethod.find(:all,:conditions => ["to_be_removed = true"]).each do |i|
      unless Employment.find_by_payment_method_id(i.id).nil?
        i.to_be_removed = false
        i.save
      else
        i.destroy
      end
    end

    puts "destroy suspension type"
    SuspensionType.find(:all,:conditions => ["to_be_removed = true"]).each do |i|
      unless Employment.find_by_suspension_type_id(i.id).nil?
        i.to_be_removed = false
        i.save
      else
        i.destroy
      end
    end

    puts "destroy termination method"
    TerminationMethod.find(:all,:conditions => ["to_be_removed = true"]).each do |i|
      unless Employment.find_by_termination_method_id(i.id).nil?
        i.to_be_removed = false
        i.save
      else
        i.destroy
      end
    end

    puts "destroy organisation type"
    OrganisationType.find(:all,:conditions => ["to_be_removed = true"]).each do |i|
      unless Organisation.find_by_organisation_type_id(i.id).nil?
        i.to_be_removed = false
        i.save
      else
        i.destroy
      end
    end

    puts "destroy payment day"
    PaymentDay.find(:all,:conditions => ["to_be_removed = true"]).each do |i|
      unless Employment.find_by_payment_day_id(i.id).nil?
        i.to_be_removed = false
        i.save
      else
        i.destroy
      end
    end


    puts "destroy security question"
    SecurityQuestion.find(:all,:conditions => ["to_be_removed = true"]).each do |i|
      if (LoginAccount.find_by_security_question1_id(i.id).nil? && LoginAccount.find_by_security_question2_id(i.id).nil? && LoginAccount.find_by_security_question3_id(i.id).nil?)
        i.destroy
      else
        i.to_be_removed = false
        i.save
      end
    end

    puts "destroy business category"
    BusinessCategory.find(:all,:conditions => ["to_be_removed = true"]).each do |i|
      unless Organisation.find_by_business_category_id(i.id).nil?
        i.to_be_removed = false
        i.save
      else
        i.destroy
      end
    end

    puts "destroy link module"
    LinkModule.find(:all,:conditions => ["to_be_removed = true"]).each do |i|
      unless ReceiptAccount.find_by_link_module_id(i.id).nil?
        i.to_be_removed = false
        i.save
      else
        i.destroy
      end
    end

    puts "destroy received via"
    ReceivedVia.find(:all,:conditions => ["to_be_removed = true"]).each do |i|
      unless TransactionHeader.find_by_received_via_id(i.id).nil?
        i.to_be_removed = false
        i.save
      else
        i.destroy
      end
    end






    puts "Destroy Keyword"
    Keyword.find(:all,:conditions=>["to_be_removed = true"]).each do |i|
      unless KeywordLink.find_by_keyword_id(i.id).nil?
        i.to_be_removed = false
        i.save
      else
        i.destroy
      end
    end

    puts "Destroy KeywordType"
    KeywordType.find(:all,:conditions => ["to_be_removed = true"]).each do |i|
      i.destroy
    end

    puts "Destroy Role"
    Role.find(:all,:conditions=>["to_be_removed = true"]).each do |i|
      unless PersonRole.find_by_role_id(i.id).nil?
        i.to_be_removed = false
        i.save
      else
        i.destroy
      end
    end


    puts "Destroy RoleType"
    RoleType.find(:all,:conditions => ["to_be_removed = true"]).each do |i|
      i.destroy
    end
  end

  def destroy_tag
    puts "destroy custom groups"
    custom_group = GroupMetaMetaType.find_custom_group
    customer_group_children = GroupMetaType.find(:all, :conditions => ["tag_meta_type_id = ?", custom_group.id])
    customer_group_children.each do |c|
      GroupType.find(:all, :conditions => ["tag_type_id = ? AND to_be_removed = true", c.id]).each do |i|
        if PersonGroup.find_by_tag_id(i.id).nil?
          i.destroy
        else
          i.to_be_removed = false
          i.save
        end
      end
    end

    puts "destroy security groups"
    security_group = GroupMetaMetaType.find_security_group
    security_group_children = GroupMetaType.find(:all, :conditions => ["tag_meta_type_id = ?", security_group.id])
    security_group_children.each do |s|
      GroupType.find(:all, :conditions => ["tag_type_id = ? AND to_be_removed = true", s.id]).each do |i|
        if UserGroup.find_by_group_id(i.id).nil?
          i.destroy
        else
          i.to_be_removed = false
          i.save
        end
      end
    end

    GroupMetaType.find(:all, :conditions => ["to_be_removed = true"]).each do |i|
      i.destroy
    end

    puts "destroy masterdoc type"
    MasterDocType.find(:all, :conditions => ["to_be_removed = true"]).each do |i|
      if MasterDoc.find_by_master_doc_type_id(i.id).nil?
        i.destroy
      else
        i.to_be_removed = false
        i.save
      end
    end

    MasterDocMetaType.find(:all, :conditions => ["to_be_removed = true"]).each do |i|
      i.destroy
    end

    MasterDocMetaMetaType.find(:all, :conditions => ["to_be_removed = true"]).each do |i|
      i.destroy
    end

    puts "destroy contact meta type"
    ContactMetaType.find(:all, :conditions => ["to_be_removed = true"]).each do |i|
      if Contact.find_by_contact_meta_type_id(i.id).nil?
        i.destroy
      else
        i.to_be_removed = false
        i.save
      end
    end

    puts "destroy receipt meta type"
    ReceiptMetaType.find(:all, :conditions => ["to_be_removed = true"]).each do |i|
      if TransactionHeader.find_by_receipt_type_id(i.id).nil?
        i.destroy
      else
        i.to_be_removed = false
        i.save
      end
    end
  end

  def destroy_receipting
    puts "destroy receipt account"
    ReceiptAccount.find(:all, :conditions => ["to_be_removed = true"]).each do |i|
      if TransactionAllocation.find_by_receipt_account_id(i.id).nil?
        i.destroy
      else
        i.to_be_removed = false
        i.save
      end
    end

    puts "destroy campaign"
    Campaign.find(:all, :conditions => ["to_be_removed = true"]).each do |i|
      if TransactionAllocation.find_by_campaign_id(i.id).nil?
        i.destroy
      else
        i.to_be_removed = false
        i.save
      end
    end

    puts "destroy source"
    Source.find(:all, :conditions => ["to_be_removed = true"]).each do |i|
      if TransactionAllocation.find_by_source_id(i.id).nil?
        i.destroy
      else
        i.to_be_removed = false
        i.save
      end
    end

    puts "destroy client bank account"
    ClientBankAccount.find(:all, :conditions => ["to_be_removed = true"]).each do |i|
      if TransactionHeader.find_by_bank_account_id(i.id).nil?
        i.destroy
      else
        i.to_be_removed = false
        i.save
      end
    end

    puts "destroy message template"
    MessageTemplate.find(:all, :conditions => ["to_be_removed = true"]).each do |i|
      i.destroy
    end
  end
end

