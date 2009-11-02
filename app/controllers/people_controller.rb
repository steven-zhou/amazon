class PeopleController < ApplicationController
  
  include PeopleSearch

  skip_before_filter :verify_authenticity_token, :only => [:show, :edit]
  protect_from_forgery :except => [:post_data]
  
  def new
   
    @person = Person.new
    @person.addresses.build
    @person.phones.build
    @person.faxes.build
    @person.emails.build
    @person.websites.build
    @image = Image.new
    @postcodes = DomesticPostcode.find(:all)
    @personal_check_field = Array.new
    
    @duplication_formula_appiled = PersonalDuplicationFormula.applied_setting
    unless @duplication_formula_appiled.nil?
      @duplication_formula_appiled.duplication_formula_details.each do |i|
        @personal_check_field << i.field_name
      end
    end


    respond_to do |format|
      format.html
    end
  end
  
  def show
    check_user

    #when it is cal show action
    if request.get?
      if @list_headers.blank?
        @list_header = ListHeader.new
        @person = Person.new
        @p = Array.new
      else
        if params[:id].nil? || params[:id] == "show" #when just jumping or change list
          @list_header = @list_headers.first
          session[:current_list_id] = @list_header.id
          #@person = @list_headers.first.people_on_list.first unless @list_headers.blank?
          @person = @list_headers.first.people_on_list.first unless @list_headers.blank?
          session[:current_person_id] = @person.id
          @person = Person.new if @person.nil?
          @p = Array.new
          @p = @list_header.people_on_list
        else  #when there is id come---click the narrow button
          unless session[:current_list_id].blank?
            @list_header = ListHeader.find(session[:current_list_id])
            @p = Array.new
            @p = @list_header.people_on_list
            @person = Person.find_by_id(params[:id].to_i)
            session[:current_person_id] = @person.id
            #else
          end
        end
      end
    end

    if request.post?
      @list_header = ListHeader.find(params[:list_header_id])
      params[:id] = params[:person_id] unless (params[:person_id].nil? || params[:person_id].empty?)

      c1 = Array.new
      c1 = @list_header.people_on_list
      @person = Person.find_by_id(params[:id].to_i)
      unless c1.include?(@person)
        @person = @list_header.people_on_list.first
      else
        @person
      end
      @p = Array.new
      @p = @list_header.people_on_list
      session[:current_list_id] = @list_header.id
      session[:current_person_id] = @person.id
    end

    @primary_phone = @person.primary_phone
    @primary_email = @person.primary_email
    @primary_fax = @person.primary_fax
    @primary_website = @person.primary_website
    @primary_address = @person.primary_address
    @primary_employment = @person.primary_employment
    @other_phones = @person.other_phones
    @other_emails = @person.other_emails
    @other_faxes = @person.other_faxes
    @other_websites = @person.other_websites
    @other_addresses = @person.other_addresses
    @notes = @person.notes
    @person_role = @person.person_roles
    
    respond_to do |format|
      
      format.html

    end

    # redirect_to "show.html"
     
  end

  
  def edit
    check_user

    @postcodes = DomesticPostcode.find(:all)

    if request.get?
      if @list_headers.blank?
        @list_header = ListHeader.new
        @person = Person.new
        @p = Array.new
      else
        unless session[:current_list_id].blank? && session[:current_person_id].blank?
          if params[:id].blank? || params[:id] == "show"
            @list_header = ListHeader.find(session[:current_list_id])
            @p = Array.new
            @p = @list_header.people_on_list
            @person = Person.find(session[:current_person_id])
          else
            @list_header = ListHeader.find(session[:current_list_id])
            @p = Array.new
            @p = @list_header.people_on_list
            @person = Person.find_by_id(params[:id].to_i)
            session[:current_person_id] = @person.id
          end
        else
          @list_header = @list_headers.first
          session[:current_list_id] = @list_header.id
          @person = @list_headers.first.people_on_list.first unless @list_headers.blank?
          session[:current_person_id] = @person.id
          @person = Person.new if @person.nil?
          @p = Array.new
          @p = @list_header.people_on_list
        end
      end
    end

    if request.post?
      @list_header = ListHeader.find(params[:list_header_id])
      params[:id] = params[:person_id] unless (params[:person_id].nil? || params[:person_id].empty?)
      c1 = Array.new
      c1 = @list_header.people_on_list
      @person = Person.find_by_id(params[:id].to_i)
      unless c1.include?(@person)
        @person = @list_header.people_on_list.first
      else
        @person
      end
      @p = Array.new
      @p = @list_header.people_on_list
      session[:current_list_id] = @list_header.id
      session[:current_person_id] = @person.id
    end

    #    @person = Person.new(:id => "") unless !@person.nil?
    @address = Address.new
    @phone = Phone.new
    @email = Email.new
    @fax = Fax.new
    @website = Website.new
    @masterdoc = MasterDoc.new
    @relationship = Relationship.new
    @employment = Employment.new
    @note = Note.new
    @image = @person.image unless (@person.nil? || @person.image.nil?)
    @role = Role.new
    @person_role = PersonRole.new
    @person_group = PersonGroup.new
    @personal_check_field = Array.new
    @duplication_formula_appiled = PersonalDuplicationFormula.applied_setting
    unless @duplication_formula_appiled.nil?
      @duplication_formula_appiled.duplication_formula_details.each do |i|
        @personal_check_field << i.field_name
      end
    end

   

    respond_to do |format|
      format.html
   
    end



    #    end

 
  end

  def create
    @person = Person.new(params[:person])
    @person.onrecord_since = Date.today()
    if @person.save
      if !params[:image].nil?
        @image = Image.new(params[:image])
        if @image.save
          @person.image = @image
        else
          flash[:warning] = "The image was not saved."
        end
      end

      # If the user wants to edit the record they just added
      if(params[:edit])
        flash[:message] = "Sucessfully added ##{@person.id} - #{@person.name}"
        redirect_to edit_person_path(@person)
        # If the user wants to continue adding records
      else
        flash[:message] = "Sucessfully added ##{@person.id} - #{@person.name} (<a href=#{edit_person_path(@person)}>edit details</a>)"
        redirect_to new_person_path
      end
    else
      @person.addresses.build(params[:person][:addresses_attributes][0]) if @person.addresses.empty?
      @person.phones.build(params[:person][:phones_attributes][0]) if @person.phones.empty?
      @person.emails.build(params[:person][:emails_attributes][0]) if @person.emails.empty?
      @person.websites.build(params[:person][:websites_attributes][0]) if @person.websites.empty?
      @postcodes = DomesticPostcode.find(:all)
      flash[:warning] = "There was an error creating a new user profile. Please check you entered a family name."
      redirect_to new_person_path
    end
  end

  def update

    @person = Person.find(params[:id])
    Image.transaction do
      unless params[:image].nil?
        @image = Image.new(params[:image])
        if @image.save
          @person.image.destroy unless @person.image.nil?
          @person.image = @image
        else
          flash[:warning] = "The image was not saved. Please check that file was a valid image file."
        end
      end
    end

    @person.update_attributes(params[:person])
    flash[:warning] = "There was an error updating the person's details." unless @person.save
  

    flash[:message] = "#{@person.name}'s information was updated successfully." unless !flash[:warning].nil?
    if(params[:edit])
      redirect_to edit_person_path(@person)
    else
      redirect_to person_path(@person)
    end
  end

  def search
    @person = Person.new
    if params[:person]
      @people = PeopleSearch.by_name(params[:person])
    elsif params[:phone]
      @people = PeopleSearch.by_phone(params[:phone])
    elsif params[:email]
      @people = PeopleSearch.by_email(params[:email])
    elsif params[:address]
      @people = PeopleSearch.by_address(params[:address])
    elsif params[:note]
      @people = PeopleSearch.by_note(params[:note])
    elsif params[:keyword]
      @people = PeopleSearch.by_keyword(params[:keyword])
    end

    #clear temple table and save result into temple table
    PeopleSearchGrid.find_all_by_login_account_id(session[:user]).each do |i|
      i.destroy
    end

    @people.each do |person|
      @psg = PeopleSearchGrid.new
      @psg.login_account_id = session[:user]
      @psg.grid_object_id = person.id
      @psg.field_1 = person.first_name
      @psg.field_2 = person.family_name
      @psg.field_3 = person.primary_address.first_line unless person.primary_address.blank?
      @psg.field_4 = person.primary_phone.value unless person.primary_phone.blank?
      @psg.field_5 = person.primary_email.address unless person.primary_email.blank?
      @psg.save
    end
    
    respond_to do |format|
      format.html
    end
  end

  def name_finder
    @person = Person.find(params[:person_id].to_i) rescue @person = Person.new
    @employment = Employment.find(params[:employment_id].to_i) rescue @employment = Employment.new
    #  reuse person.preferred_name to store update field name, if no update field, preferred_name is set to empty but will not be saved. Don't worry.
    @person.preferred_name = params[:update].nil?? nil : params[:update]   
    
    respond_to do |format|
      format.js {  }
    end
  end

  def role_finder
    @person = Person.find(params[:person_id]) rescue @person = Person.new
    @person_role = PersonRole.find(params[:person_role_id]) rescue @person_role = PersonRole.new
    #  reuse person.preferred_name to store update field name, if no update field, preferred_name is set to empty but will not be saved. Don't worry.
    @person.preferred_name = params[:update].nil?? nil : params[:update]
    respond_to do |format|
      format.js {  }
    end
  end
  
  def find
    @person = Person.new
  end
  
  def name_card
    @person = Person.find(params[:id])
    respond_to do |format|
      format.js { }
    end
  end

  def master_doc_meta_type_finder
    @master_doc_meta_types = MasterDocMetaType.find(:all, :conditions => ["tag_meta_type_id = ?", params[:id]]) rescue @master_doc_meta_types = Array.new
    @masterdoc = MasterDoc.find(params[:master_doc_id]) rescue @masterdoc = MasterDoc.new
    respond_to do |format|
      format.js { }
    end
  end

  def master_doc_type_finder
    @master_doc_types = MasterDocType.find(:all, :conditions => ["tag_type_id = ?", params[:id]]) rescue @master_doc_types = Array.new
    @masterdoc = MasterDoc.find(params[:master_doc_id]) rescue @masterdoc = MasterDoc.new
    respond_to do |format|
      format.js { }
    end
  end
  def login_id_finder
    @person = Person.find(params[:person_id]) rescue @person = Person.new
    @login_account = LoginAccount.find(params[:login_account_id]) rescue @login_account = LoginAccount.new
    @primary_email = @person.primary_email.value unless @person.primary_email.blank?
    #@person_login_account = @person.login_accounts rescue @person_login_account = LoginAccount.new
    respond_to do |format|
      format.js()
    end

  end

 

  def show_list

    @person = Person.find(params[:person_id]) rescue @person = Person.find(session[:current_person_id])
    @list_header = ListHeader.find(session[:current_list_id])
    @p = Array.new
    @p = @list_header.people_on_list
    #clear

    ShowListGrid.find_all_by_login_account_id(session[:user]).each do |i|
      i.destroy
    end

    @p.each do |person|
      @slg = ShowListGrid.new
      @slg.login_account_id = session[:user]
      @slg.grid_object_id = person.id
      @slg.field_1 = person.first_name
      @slg.field_2 = person.family_name
      @slg.field_3 = person.primary_address.first_line unless person.primary_address.blank?
      @slg.field_4 = person.primary_phone.value unless person.primary_phone.blank?
      @slg.field_5 = person.primary_email.address unless person.primary_email.blank?
      @slg.save
    end

    @current_operation = params[:current_operation]

    respond_to do |format|
      format.js
    end
  end





  def show_left
 
    check_user
    @person = Person.find(params[:person_id]) rescue @person = Person.find(session[:current_person_id])
    @list_header = ListHeader.find(session[:current_list_id])
    @p = Array.new
    @p = @list_header.people_on_list
    @primary_phone = @person.primary_phone
    @primary_email = @person.primary_email
    @primary_fax = @person.primary_fax
    @primary_website = @person.primary_website
    @primary_address = @person.primary_address
    @primary_employment = @person.primary_employment
    @other_phones = @person.other_phones
    @other_emails = @person.other_emails
    @other_faxes = @person.other_faxes
    @other_websites = @person.other_websites
    @other_addresses = @person.other_addresses
    @notes = @person.notes
    @person_role = @person.person_roles
    session[:select_list_person] = params[:person_id]
    #   session[:current_person_id]=params[:person_id]

    @personal_check_field = Array.new
    @duplication_formula_appiled = PersonalDuplicationFormula.applied_setting
    unless @duplication_formula_appiled.nil?
      @duplication_formula_appiled.duplication_formula_details.each do |i|
        @personal_check_field << i.field_name
      end
    end
 
     
    if(params[:current_operation] == "edit_list")
      @postcodes = DomesticPostcode.find(:all)
      @current_action = "edit"
      @address = Address.new
      @phone = Phone.new
      @email = Email.new
      @fax = Fax.new
      @website = Website.new
      @masterdoc = MasterDoc.new
      @relationship = Relationship.new
      @employment = Employment.new
      @note = Note.new
      @image = @person.image unless (@person.nil? || @person.image.nil?)
      @role = Role.new
      @person_role = PersonRole.new
      @person_group = PersonGroup.new
      render 'show_edit_left.js'

    else
      @primary_phone = @person.primary_phone
      @primary_email = @person.primary_email
      @primary_fax = @person.primary_fax
      @primary_website = @person.primary_website
      @primary_address = @person.primary_address
      @primary_employment = @person.primary_employment
      @other_phones = @person.other_phones
      @other_emails = @person.other_emails
      @other_faxes = @person.other_faxes
      @other_websites = @person.other_websites
      @other_addresses = @person.other_addresses
      @notes = @person.notes
      @person_role = @person.person_roles
      @current_action = "show"
      respond_to do |format|
        format.js
      end
      #    redirect_to :action => "show", :id => @person.id
    end


  end






  def search_lists

    @name_search=params[:name]
    @email_search=params[:email]
    @phone_search=params[:phone]
    @list_people_id = session[:current_list_id]
    @list_people = ListHeader.find(session[:current_list_id]).people_on_list
    @search_list_result=@list_people.find(:all)
    @search_list_result = @list_people.find(:all,:include => [:contacts], :conditions => ["contacts.value ILIKE ?","%#{@email_search}%"])
    respond_to do |format|
      format.js
    end
  end


  def check_duplication

    @personal_duplication_formula = PersonalDuplicationFormula.applied_setting
    duplication_value = ""
    unless @personal_duplication_formula.nil?
      @personal_duplication_formula.duplication_formula_details.each do |i|

        if(i.is_foreign_key==true)
          if (i.field_name =="primary_title" || i.field_name =="secondary_title" ) # judge is primar_title or secondary_title. If yes , search the name from Title Table
            duplication_value+=Title.find(params[i.field_name.to_sym]).name[0,i.number_of_charecter]
          else
            duplication_value+=params[i.field_name.to_sym].camelize.constantize.find(params[i.field_name.to_sym]).name[0,i.number_of_charecter] # Put params string to object to find the name
          end
        else
          duplication_value+=params[i.field_name.to_sym][0,i.number_of_charecter]
        end
      end
      #      puts "*******************#{duplication_value}******************"
      if(params[:id]!="")
        @dup_personal = Person.find(:all, :conditions => ["duplication_value ILIKE ? AND id !=?" , duplication_value, params[:id]])
      else
        @dup_personal = Person.find(:all, :conditions => ["duplication_value ILIKE ?" , duplication_value])

      end

      

      DuplicationPersonalGrid.find_all_by_login_account_id(session[:user]).each do |i|
        i.destroy
      end

      @dup_personal.each do |person|
        @dup_person = DuplicationPersonalGrid.new
        @dup_person.login_account_id = session[:user]
        @dup_person.grid_object_id = person.id
        @dup_person.field_1 = person.first_name
        @dup_person.field_2 = person.family_name
        @dup_person.field_3 =person.primary_address.first_line unless person.primary_address.blank?
        @dup_person.field_4 = person.primary_phone.value unless person.primary_phone.blank?
        @dup_person.field_5 = person.primary_email.address unless person.primary_email.blank?
        @dup_person.save
      end
      
      
    end
   
    respond_to do |format|
      format.js
    end



  end

  def postcode_look_up
    @postcode = Postcode.find(params[:id])
    @postcode_town = params[:update_field1]
    @postcode_state = params[:update_field2]
    @postcode_post_code = params[:update_field3]
    @postcode_country = params[:update_field4]

    respond_to do |format|
      format.js
    end
  end


  def  show_postcode

    if ShowPostcodeGrid.find_all_by_login_account_id(session[:user]).empty?
     @postcode = Postcode.find(:all)

     @postcode.each do |i|
       @spc = ShowPostcodeGrid.new
        @spc.login_account_id = session[:user]
        @spc.grid_object_id = i.id
        @spc.field_1 = i.state
        @spc.field_2 = i.suburb
        @spc.field_3 = i.postcode
        @spc.field_4 = i.country.short_name
        @spc.save
     end

    end

     respond_to do |format|
      format.js
    end

      
   
  end

  def lookup  #  look up person in the list
    @update_field = params[:update_field]
    if PersonLookupGrid.find_all_by_login_account_id(session[:user]).empty?

      @templist = TempList.find_by_login_account_id(session[:user])
      @people = @templist.people_on_list
      @people.each do |j|

        @solg = PersonLookupGrid.new
        @solg.login_account_id = session[:user]
        @solg.grid_object_id = j.id
        @solg.field_1 = j.first_name
        @solg.field_2 = j.family_name
        @solg.field_3 = j.primary_address.first_line unless j.primary_address.blank?
        @solg.field_4 = j.primary_phone.value unless j.primary_phone.blank?
        @solg.field_5 = j.primary_email.address unless j.primary_email.blank?
        
        @solg.save
        
       
      end
    end
    respond_to do |format|
      format.js
    end

  end


  def lookup_fill
    @update_field = params[:update_field]
    @person = Person.find(params[:id].to_i)
    respond_to do |format|
      format.js
    end
  end

  private
  def check_user
    if session[:super_admin]
      @group_types = GroupType.find(:all, :order => "name")
      @list_headers = ListHeader.find(:all, :order =>"name")

    else
      @group_types = LoginAccount.find(session[:user]).group_types
      @list_headers = @current_user.list_headers
    end
  end

end
