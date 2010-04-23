
class PeopleController < ApplicationController
  #cache pages
  #caches_action :show_list, :find
  #cache_sweeper :person_sweeper, :only => [:create, :update, :destroy]

  # Added system logging
  #caches_page :show_album

  include PeopleSearch
  skip_before_filter :verify_authenticity_token, :only => [:show, :edit]
  protect_from_forgery :except => [:post_data]





  def new
   
    @person = Person.new
    @person.addresses.build
    @person.phones.build
    #@person.faxes.build
    @person.emails.build
    @person.websites.build
    @person.instant_messagings.build
    @image = Image.new
    #@postcodes = Postcode.find(:all)
    @personal_check_field = Array.new
    @active_title = Title.active_title
    @countries = Country.all
    @active_address_types = AddressType.active_address_type
    @Languages = Language.active_language

    @phone_types = Contact.phone_types
    @email_types = Contact.email_types
    @website_types = Contact.website_types

    
    @duplication_formula_appiled = PersonalDuplicationFormula.applied_setting
    
    unless @duplication_formula_appiled.status == false
      @duplication_formula_details =@duplication_formula_appiled.duplication_formula_details
      @duplication_formula_details.each do |i|
        @personal_check_field << i.field_name
      end
    end
    @p = PrimaryList.first.entity_on_list

    respond_to do |format|

      format.html
      #      format.js {render "new.js"}
    end
  end
  
  def show
   
    
    # if no person in the system , go to person new directly
    if PrimaryList.first.entity_on_list.empty?
      redirect_to :action=>"new"
    else
      #@group_types = @current_user.group_types
      @list_headers = @current_user.all_person_lists
      @active_tab = params[:active_tab]
      @active_sub_tab = params[:active_sub_tab]
      #when it is cal show action
      if request.get?
        
        if @list_headers.blank?
          @list_header = ListHeader.new
          @person = Person.new
          @p = Array.new
          flash[:warning] = "No List Found Within Your Group"
          redirect_to :controller => "module", :action => "dashboard" and return
        else
          if params[:id].nil? || params[:id] == "show" #when just jumping or change list
            @list_header = @current_user.default_value.try(:default_list_header).nil? ? @list_headers.first : @current_user.default_value.try(:default_list_header)

            session[:current_list_id] = @list_header.id
            @person = @list_header.entity_on_list.first unless @list_headers.blank?
            @person = Person.new if @person.nil?
            session[:current_person_id] = @person.id unless @person.new_record?
            @p = Array.new
            @p = @list_header.entity_on_list.uniq
          else  #when there is id come---click the narrow button
            unless session[:current_list_id].blank?

              @list_header = ListHeader.find(session[:current_list_id])

              @p = Array.new
              @p = @list_header.entity_on_list.uniq
              @person = Person.find_by_id(params[:id].to_i)

              @person = @p.first if @person.nil?
              session[:current_person_id] = @person.id

              #else
            end
          end
         end
      end

      if request.post?
        #remember the active style of tabs

        @list_header = ListHeader.find(params[:list_header_id])
        params[:id] = params[:person_id] unless (params[:person_id].nil? || params[:person_id].empty?)

        c1 = Array.new
        c1 = @list_header.entity_on_list
        @person = Person.find_by_id(params[:id].to_i)
        unless c1.include?(@person)
          @person = c1.first
        else
          @person
        end

        @p = Array.new
        @p = c1.uniq
        session[:current_list_id] = @list_header.id
        session[:current_person_id] = @person.id
      end

      @primary_phone = @person.primary_phone
      @primary_email = @person.primary_email
      @primary_fax = @person.primary_fax
      @primary_website = @person.primary_website
      @primary_address = @person.primary_address
      @primary_employment = @person.primary_employment
      #    @other_phones = @person.other_phones
      #    @other_emails = @person.other_emails
      #    @other_faxes = @person.other_faxes
      #    @other_websites = @person.other_websites
      #    @other_addresses = @person.other_addresses
      #    @notes = @person.notes
      #    @instant_messaging = @person.instant_messagings
      #    @person_role = @person.person_roles

      respond_to do |format|

        format.html
        format.js {render 'show_left.js'}

      end
    end
  end

  def edit
   
    # if no person in the system , go to person new directly
    if PrimaryList.first.entity_on_list.empty?
      redirect_to :action=>"new"

    else

      # @group_types = LoginAccount.find(session[:user]).group_types
      @list_headers = @current_user.all_person_lists
      @active_tab = params[:active_tab]
      @active_sub_tab = params[:active_sub_tab]



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
              @p = @list_header.entity_on_list.uniq
              @person = Person.find(session[:current_person_id]) rescue @person = Person.first
            else
              @list_header = ListHeader.find(session[:current_list_id])
              @p = Array.new
              @p = @list_header.entity_on_list.uniq
              @person = Person.find_by_id(params[:id].to_i)
              @person = @list_headers.first.entity_on_list.first if @person.nil?
              session[:current_person_id] = @person.id
            end
          else
            @list_header = @current_user.default_value.try(:default_list_header).blank? ? @list_headers.first : @current_user.default_value.try(:default_list_header)
            session[:current_list_id] = @list_header.id
            @person = @list_headers.first.entity_on_list.first unless @list_headers.blank?
            session[:current_person_id] = @person.id
            @person = Person.new if @person.nil?
            @p = Array.new
            @p = @list_header.entity_on_list.uniq
          end
        end
      end

      if request.post?
        @list_header = ListHeader.find(params[:list_header_id])
        params[:id] = params[:person_id] unless (params[:person_id].nil? || params[:person_id].empty?)
        c1 = Array.new
        c1 = @list_header.entity_on_list.uniq
        @person = Person.find_by_id(params[:id].to_i)
        unless c1.include?(@person)
          @person = @list_header.entity_on_list.first
        else
          @person
        end
        @p = Array.new
        @p = @list_header.entity_on_list.uniq
        session[:current_list_id] = @list_header.id
        session[:current_person_id] = @person.id
      end

      #----for left side use
      @active_address = AddressType.active_address_type
      @active_title = Title.active_title
      @countries = Country.all #
      @Languages = Language.active_language #
      #-----for first tab use
      @address = Address.new #
      @phone = Phone.new #
      @email = Email.new #
      @fax = Fax.new #
      @website = Website.new #
      @instant_messaging = InstantMessaging.new #

      @image = @person.image unless (@person.nil? || @person.image.nil?)

      @personal_check_field = Array.new
      @duplication_formula_appiled = PersonalDuplicationFormula.applied_setting
      unless @duplication_formula_appiled.status == false
        @duplication_formula_appiled.duplication_formula_details.each do |i|
          @personal_check_field << i.field_name
        end
      end
      @entity = @person
      puts "**********"
      puts @person
      puts @p
      respond_to do |format|
        format.html
        format.js {render 'show_edit_left.js'}
      end
    end
  end

  def create
    
    check_valid_date = params[:person][:birth_date].blank? ? true : valid_date(params[:person][:birth_date])
    if check_valid_date

      @person = Person.new(params[:person])
      @person.onrecord_since = Date.today()
      if @person.save
        #to save to the person primary email address and pirmary phone address
        @person.primary_email_address = @person.try(:emails).find_by_priority_number(1).try(:value)
        @person.primary_phone_num = @person.try(:phones).find_by_priority_number(1).try(:value)
        @person.save


        #create default custom field for new person
        @extra_types = ExtraMetaType.active
        i=1
        @extra_types.each do |group|
          @extra =  Extra.new
          @extra.entity_id = @person.id
          @extra.group_id = group.id
          @extra.entity_type = "Person"
          group.extra_types.each do |label|
            @extra.__send__(("label#{i}_id=").to_sym,label.id)
            @extra.__send__(("label#{i}_value=").to_sym,nil)
            i=i+1
          end
          @extra.save
          i=1
        end

        system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new Person with ID #{@person.id}.")
        if !params[:image].nil?
          @image = Image.new(params[:image])
          if @image.save
            @person.image = @image
          else
            flash[:warning_before_message] = "There Was an Error to Save the Selected Image."
          end
        end

        # edit by Tao, "submit and edit" button is removed, code is commit for further checking.
        # If the user wants to edit the record they just added
        #      if(params[:edit])
        #        flash[:message] = "Sucessfully added ##{@person.id} - #{@person.name}"
        #        redirect_to edit_person_path(@person)
        #        # If the user wants to continue adding records
        #      else
        flash[:message] = "Sucessfully added ##{@person.id} - #{@person.name} (<a href='/people/#{@person.id}/edit' style='color:white;'>edit details</a>)"
        #         redirect_to new_person_path
        #end
      else
        @person.addresses.build(params[:person][:addresses_attributes][0]) if @person.addresses.empty?
        @person.phones.build(params[:person][:phones_attributes][0]) if @person.phones.empty?
        @person.emails.build(params[:person][:emails_attributes][0]) if @person.emails.empty?
        @person.websites.build(params[:person][:websites_attributes][0]) if @person.websites.empty?
        #@postcodes = Postcode.find(:all)
        @image = Image.new

        @personal_check_field = Array.new
        @duplication_formula_appiled = PersonalDuplicationFormula.applied_setting
        unless @duplication_formula_appiled.status == false
          @duplication_formula_appiled.duplication_formula_details.each do |i|
            @personal_check_field << i.field_name
          end
        end

        flash[:error] = "There Was an Error to Create a New User"
        #      redirect_to new_person_path
        #      render :action => "new"
    
      end

    else

      flash[:error] = "Please make sure the start date and end date are entered in valid format (dd-mm-yyyy)"
       
    end
    redirect_to new_person_path
  end

  def update

    check_valid_date = params[:person][:birth_date].blank? ? true : valid_date(params[:person][:birth_date])

    @person = Person.find(params[:id])
    if check_valid_date
      Image.transaction do
        unless params[:image].nil?
          @image = Image.new(params[:image])
          if @image.save
            @person.image.destroy unless @person.image.nil?
            @person.image = @image
          else
            flash[:warning] = "There Was an Error to Save the Selected Image."
          end
        end
      end



      @person.update_attributes(params[:person])
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated Person #{@person.id}.")
      flash[:warning] = "There was an error updating the person's details." unless @person.save
  

      flash[:message] = "#{@person.name}'s information was updated successfully." unless !flash[:warning].nil?
      #modified by Tao, removing "submit and close", code is commited for further checking
      #if(params[:edit])
    else
      flash[:warning] = "Please make sure the start date and end date are entered in valid format (dd-mm-yyyy)"
    end
    redirect_to edit_person_path(@person)
    #else
    #    redirect_to person_path(@person)
    #end
  end

  def search
    @person = Person.new   
    if params[:person]
      unless params[:person][:age].blank?
        @current_time = Time.now
        params[:person][:age] = (@current_time.year-params[:person][:age].to_i).to_s
      end
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
    @person = Person.find_by_id(params[:person_id]) rescue @person = Person.new
    @person = Person.new if @person.nil?
    @employment = Employment.find(params[:employment_id].to_i) rescue @employment = Employment.new
    # use @update to store the name of field that needed to be update in the view, i.e. supervisor_container
    @update = params[:update].nil? ? nil : params[:update]
    @input_field_id = params[:input_field_id]  #to clear the input field
    respond_to do |format|
      format.js {  }
    end
  end

  def general_name_show
    @person = Person.find_by_id(params[:person_id]) rescue @person = Person.new
    @person = Person.new if @person.nil?  #handle the situation when @person return nil
    @update_field = params[:update_field]# for name field updating
    @input_field = params[:input_field]  #to clear the input field
    respond_to do |format|
      format.js {render 'general_name_show.js'}
    end
  end

  def role_finder
 
    @person = Person.find_by_id(params[:person_id]) rescue @person = Person.new #if input a string like "1u", it will run thee rescue, but if input a '14444', if will return nil

    @person = Person.new if @person.nil?  #handle the situation when @person return nil

    @person_role = PersonRole.find(params[:person_role_id]) rescue @person_role = PersonRole.new
    #  reuse person.preferred_name to store update field name, if no update field, preferred_name is set to empty but will not be saved. Don't worry.
    @person.preferred_name = params[:update].nil? ? nil : params[:update]
    @input_field_id = params[:input_field_id] #to clear the input field
    respond_to do |format|
      format.js {  }
    end
  end
  
  def find
    @person = Person.new
    @active_title = Title.active_title
    @countries = Country.all
    @Languages = Language.active_language
  end
  
  def name_card
    @person = Person.find(params[:id])
    respond_to do |format|
      format.js { }
    end
  end

  def master_doc_meta_type_finder
    @master_doc_meta_types = MasterDocMetaType.find(:all, :conditions => ["tag_meta_type_id = ? and status=true ", params[:id]]) rescue @master_doc_meta_types = Array.new
    @masterdoc = MasterDoc.find(params[:master_doc_id]) rescue @masterdoc = MasterDoc.new
    respond_to do |format|
      format.js { }
    end
  end

  def master_doc_type_finder
    @master_doc_types = MasterDocType.find(:all, :conditions => ["tag_type_id = ? and status=true", params[:id]]) rescue @master_doc_types = Array.new
    @masterdoc = MasterDoc.find(params[:master_doc_id]) rescue @masterdoc = MasterDoc.new
    respond_to do |format|
      format.js { }
    end
  end


  def login_id_finder
    @person = Person.find(params[:person_id]) rescue @person = Person.new
    puts"---debug-@person- #{@person.to_yaml}-----"
    @person = Person.new if @person.nil?  #handle the situation when @person return nil
    puts"---debug-@perso2- #{@person.to_yaml}-----"
    @person_valid = @person.new_record? ? false : true
    puts"---debug-@person_valid- #{@person_valid.to_yaml}-----"
    if @person_valid == true
      @person_unique_valid = @person.login_accounts.blank? ? true : false
    end
    puts"---debug-@person_unique_valid- #{@person_unique_valid.to_yaml}-----"
    @validation = @person_valid && @person_unique_valid
    puts"---debug-@validation- #{@validation.to_yaml}-----"
    @primary_email = @person.try(:primary_email).try(:value) if @validation == true
    puts"---debug-- #{@primary_email.to_yaml}-----"
    respond_to do |format|
      format.js
    end
  end

  def show_list
    # people show
    @person = Person.find(params[:person_id]) rescue @person = Person.find(session[:current_person_id])
    @list_header = ListHeader.find(session[:current_list_id])
    @active_tab = params[:active_tab]
    @active_sub_tab = params[:active_sub_tab]
    @current_operation = params[:current_operation]
    #----use for the pop window
    session[:active_tab]= params[:active_tab]
    session[:active_sub_tab] = params[:active_sub_tab]
    session[:current_operation] = params[:current_operation]
 
    respond_to do |format|
      format.js
    end
  end

  def show_left
   
    params[:person_id] =  params[:param1] if params[:param1]
    params[:current_operation]= session[:current_operation]
    

    @active_tab = session[:active_tab]
    @active_sub_tab = session[:active_sub_tab]
    #    check_user
    @person = Person.find(params[:person_id]) rescue @person = Person.find(session[:current_person_id])
    @active_address = AddressType.active_address_type
    @active_title = Title.active_title
    @countries = Country.all #
    @Languages = Language.active_language #

    @list_header = ListHeader.find(session[:current_list_id])
    @list_headers = @current_user.all_person_lists
 
    @p = Array.new
    @p = @list_header.entity_on_list
    @primary_phone = @person.primary_phone
    @primary_email = @person.primary_email
    @primary_fax = @person.primary_fax
    @primary_website = @person.primary_website
    @primary_address = @person.primary_address
    @primary_employment = @person.primary_employment
    #    @other_phones = @person.other_phones
    #    @other_emails = @person.other_emails
    #    @other_faxes = @person.other_faxes
    #    @other_websites = @person.other_websites
    #    @other_addresses = @person.other_addresses
    #    @notes = @person.notes
    #    @instant_messaging = @person.instant_messagings
    #    @person_role = @person.person_roles




    session[:select_list_person] = params[:person_id]
    #   session[:current_person_id]=params[:person_id]

    @personal_check_field = Array.new
    @duplication_formula_appiled = PersonalDuplicationFormula.applied_setting
    unless @duplication_formula_appiled.status == false
      @duplication_formula_appiled.duplication_formula_details.each do |i|
        @personal_check_field << i.field_name
      end
    end
 
     
    if(params[:current_operation] == "edit_list")
      #@postcodes = Postcode.find(:all)
      @current_action = "edit"
      # @address = Address.new
      @phone = Phone.new
      @email = Email.new
      @fax = Fax.new
      @website = Website.new
      @instant_messaging = InstantMessaging.new
      #  @masterdoc = MasterDoc.new
      # @relationship = Relationship.new
      # @employment = Employment.new
      # @note = Note.new
      @image = @person.image unless (@person.nil? || @person.image.nil?)
      #  @role = Role.new
      #  @person_role = PersonRole.new
      #  @bank_accounts = PersonBankAccount.new
      #  @person_group = PersonGroup.new
      render 'show_edit_left.js'

    else
      @primary_phone = @person.primary_phone
      @primary_email = @person.primary_email
      @primary_fax = @person.primary_fax
      @primary_website = @person.primary_website
      @primary_address = @person.primary_address
      @primary_employment = @person.primary_employment
      #  @other_phones = @person.other_phones
      #  @other_emails = @person.other_emails
      #  @other_faxes = @person.other_faxes
      #      @other_websites = @person.other_websites
      #      @other_addresses = @person.other_addresses
      #      @notes = @person.notes
      #      @person_role = @person.person_roles
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
    @list_people = ListHeader.find(session[:current_list_id]).entity_on_list
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
          if (i.field_name == "primary_title" || i.field_name == "secondary_title" ) # judge is primar_title or secondary_title. If yes , search the name from Title Table
            title = Title.find(params[(i.field_name).to_sym]) rescue title = nil
            unless title.nil?
              duplication_value << title.name[0,i.number_of_charecter]
            end
          else
            unless params[i.field_name.to_sym].blank? && params[i.field_name.to_sym].camelize.constantize.find(params[i.field_name.to_sym]).nil?
              duplication_value << params[i.field_name.to_sym].camelize.constantize.find(params[i.field_name.to_sym]).name[0,i.number_of_charecter] # Put params string to object to find the name
            end
          end
        else
          duplication_value << params[i.field_name.to_sym][0,i.number_of_charecter]
        end
      end
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
    @suburb = params[:suburb]
    @postcode = ""
    @state = params[:state]
    respond_to do |format|
      format.js
    end

      
   
  end

  def lookup  #  look up person in the list
    @update_field = params[:update_field]

    if !(PersonLookupGrid.find_all_by_login_account_id(session[:user]).empty?)

      PersonLookupGrid.find_all_by_login_account_id(session[:user]).each do |i|
        i.destroy
      end

    end



    #    if PersonLookupGrid.find_all_by_login_account_id(session[:user]).empty?

    @templist = TempList.find_by_login_account_id(session[:user])
    @people = @templist.entity_on_list rescue @people = PrimaryList.first.entity_on_list
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
        
       
      #      end
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


  def general_show_list

    @person = Person.find(params[:person_id]) rescue @person = Person.find(session[:current_person_id])
    @list_header = ListHeader.find(session[:current_list_id])
    @p = Array.new
    @p = @list_header.entity_on_list
    respond_to do |format|
      format.js
    end
  end

  def page_initial
    @render_page = params[:render_page]
    @field = params[:field]
    if params[:type]=="Person"
      @type = "Person"
      @person = Person.find_by_id(params[:params1])
    else
      @type = "Organisation"
      @organisation = Organisation.find_by_id(params[:params1])
    end
    respond_to do |format|
      format.js
    end
  end


  def destroy

    @person = Person.find(params[:id])
    @person.to_be_removed = @person.to_be_removed ? false : true
    @person.save
    respond_to do |format|
      format.js
    end
  end

  def change_status
    @person = Person.find(params[:param1])
    @person.status = @person.status ? false : true
    @person.save
    respond_to do |format|

      format.js
    end
  end


  def show_grid
    @person = Person.find(session[:current_person_id])
    @list_header = ListHeader.find(session[:current_list_id])

    #    @render_page = params[:render_page]
    #    @field = params[:field]



    respond_to do |format|

      format.js
    end

  end

  def show_album

    respond_to do |format|

      format.js
    end
  end


end
