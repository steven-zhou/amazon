class OrganisationsController < ApplicationController
  # Applied system logging
  include OrganisationsSearch
  skip_before_filter :verify_authenticity_token, :only => [:show, :edit]

  def new
    @organisation = Organisation.new
    @organisation.addresses.build
    @organisation.phones.build
    @organisation.faxes.build
    @organisation.emails.build
    @organisation.websites.build
    @organisation.instant_messagings.build
    @image = Image.new
    @client_setup = ClientSetup.first
    @check_field = Array.new
    @active_address_types = AddressType.active_address_type
    @countries = Country.all
    @phone_types = Contact.phone_types
    @email_types = Contact.email_types
    @website_types = Contact.website_types
    @organisational_duplication_formula = OrganisationalDuplicationFormula.applied_setting
    unless @organisational_duplication_formula.nil?
      @organisational_duplication_formula.duplication_formula_details.each do |i|
        @check_field << i.field_name
      end
    end

    respond_to do |format|
      format.html
    end
  end

  def show
    @list_headers = @current_user.all_organisation_lists
    @list_header = ListHeader.find(session[:current_org_list_id]) rescue @list_header = @list_headers.first
    @list_header = params[:list_header_id].nil? ? @list_header : ListHeader.find(params[:list_header_id])
    @active_tab = params[:active_tab]
    @active_sub_tab = params[:active_sub_tab]
    params[:id] = params[:organisation_id] unless (params[:organisation_id].nil? || params[:organisation_id].empty?)

    @list_header = OrganisationPrimaryList.first if @list_header.nil?
    @o = @list_header.entity_on_list.uniq
    @organisation = Organisation.find_by_id(params[:id].to_i)
    @organisation = @o[0] if (@organisation.nil? || !@o.include?(@organisation))
    session[:current_organisation_id] = @organisation.id
    session[:current_org_list_id] = @list_header.id

    @primary_phone = @organisation.primary_phone
    @primary_email = @organisation.primary_email
    @primary_fax = @organisation.primary_fax
    @primary_website = @organisation.primary_website
    @primary_address = @organisation.primary_address

    respond_to do |format|
      format.html
      format.js {render 'show_left.js'}

    end
  end

  def create
    check_valid_date = params[:organisation][:registered_date].blank? ? true : valid_date(params[:organisation][:registered_date])
    if check_valid_date
      @organisation = (params[:type].camelize.constantize).new(params[:organisation])
      @organisation.onrecord_since = Date.today()
      if @organisation.save
        if @organisation.level == 0
          @organisation.update_attribute('family_id',@organisation.id)
        end

        @organisation.primary_email_address = @organisation.try(:emails).find_by_priority_number(1).try(:value)
        @organisation.primary_phone_num = @organisation.try(:phones).find_by_priority_number(1).try(:value)
        @organisation.save
        system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new Organisation with ID #{@organisation.id}.")
        if !params[:image].nil?
          @image = Image.new(params[:image])
          if @image.save
            @organisation.image = @image
          else
            flash[:warning] = "There Was an Error to Save the Selected Image."
          end
        end
        @organisation_new = Organisation.new
        flash[:message] = "Sucessfully added ##{@organisation.id} - #{@organisation.full_name} (<a href='/organisations/#{@organisation.id}/edit' style='color:white'>edit details</a>)"
        #      redirect_to new_organisation_path
      else
        @organisation.addresses.build(params[:organisation][:addresses_attributes][0]) if @organisation.addresses.empty?
        @organisation.phones.build(params[:organisation][:phones_attributes][0]) if @organisation.phones.empty?
        @organisation.emails.build(params[:organisation][:emails_attributes][0]) if @organisation.emails.empty?
        @organisation.websites.build(params[:organisation][:websites_attributes][0]) if @organisation.websites.empty?
        flash[:error] = flash_message(:type => "field_missing", :field => "Full name")if (!@organisation.errors[:full_name].nil? && @organisation.errors.on(:full_name).include?("can't be blank"))

      end
    else
      flash[:error] = "Please make sure the start date and end date are entered in valid format (dd-mm-yyyy)"
    end
    redirect_to new_organisation_path
  end


  def edit
    @list_headers = @current_user.all_organisation_lists
    @list_header = ListHeader.find(session[:current_org_list_id]) rescue @list_header = @list_headers.first
    @list_header = params[:list_header_id].nil? ? @list_header : ListHeader.find(params[:list_header_id])
    @active_tab = params[:active_tab]
    @active_sub_tab = params[:active_sub_tab]
    @current_user = LoginAccount.find(session[:user])
    @client_setup = ClientSetup.first
    @super_admin = (@current_user.class.to_s == "SuperAdmin" || @current_user.class.to_s == "MemberZone") ? true : false

    @list_header = OrganisationPrimaryList.first if @list_header.nil?
    @o = @list_header.entity_on_list.uniq
    params[:id] = params[:organisation_id] unless (params[:organisation_id].nil? || params[:organisation_id].empty?)
    @organisation = Organisation.find(params[:id].to_i) rescue @organisation = @o[0]
    @organisation = @o[0] if (@organisation.nil? || !@o.include?(@organisation))
    session[:current_organisation_id] = @organisation.id
    session[:current_org_list_id] = @list_header.id
    @phone = Phone.new
    @email = Email.new
    @fax = Fax.new
    @website = Website.new
    @instant_messaging = InstantMessaging.new

    @image = @organisation.image unless (@organisation.nil? || @organisation.image.nil?)
    @check_field = Array.new
    @organisational_duplication_formula = OrganisationalDuplicationFormula.applied_setting
    unless @organisational_duplication_formula.nil?
      @organisational_duplication_formula.duplication_formula_details.each do |i|
        @check_field << i.field_name
      end
    end

    @entity = @organisation
    respond_to do |format|
      format.html
      format.js {render 'show_edit_left.js'}
    end
  end

  def update


    @organisation = Organisation.find(params[:id])
    type = @organisation.class.to_s.underscore
    check_valid_date = params[type.to_sym][:registered_date].blank? ? true : valid_date(params[type.to_sym][:registered_date])
    if check_valid_date


      Image.transaction do
        unless params[:image].nil?
          @image = Image.new(params[:image])
          if @image.save
            @organisation.image.destroy unless @organisation.image.nil?
            @organisation.image = @image
          else
            flash[:warning] = "There Was an Error to Save the Selected Image"
          end
        end
      end

      @organisation.update_attributes(params[type.to_sym])
      if params[:level] == "0"  #set to be level 0
        @organisation.level = 0
        @organisation.family_id = @organisation.id
        @organisation.save
      end
      
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated Organisation #{@organisation.id}.")
      flash[:warning] = "Organisation Update Has NOT been Submitted Due to Data Errors" unless @organisation.save
      flash[:message] = "#{@organisation.full_name}'s Details Have been Updated Successfully." unless !flash[:warning].nil?
    else
      flash[:warning] = "Please make sure the start date and end date are entered in valid format (dd-mm-yyyy)"
    end


    if(params[:installation])
      flash[:message] = "Client Organisation - #{@organisation.full_name}'s information was initialized successfully."
      redirect_to :controller => :client_setups, :action => :client_organisation
    else
      redirect_to edit_organisation_path(@organisation)
    end


  end

  def name_finder
    @organisation = Organisation.find(params[:organisation_id]) rescue @organisation = nil
    @employment = Employment.find(params[:employment_id]) rescue @employment = Employment.new
    @org_relationship = true if params[:object_id]
    @update_field = params[:update_field]
    respond_to do |format|
      format.js {  }
    end
  end

  def name_card
    @organisation = Organisation.find(params[:id])
    respond_to do |format|
      format.js { }
    end
  end


  def find
    @organisation = Organisation.new
    @countries = Country.all
  end

  def search
    @organisation = Organisation.new
    if params[:organisation]
      @organisations = OrganisationsSearch.by_name(params[:organisation])
    elsif params[:phone]
      @organisations = OrganisationsSearch.by_phone(params[:phone])
    elsif params[:email]
      @organisations = OrganisationsSearch.by_email(params[:email])
    elsif params[:address]
      @organisations = OrganisationsSearch.by_address(params[:address])
    elsif params[:note]
      @organisations = OrganisationsSearch.by_note(params[:note])
    elsif params[:keyword]
      @organisations = OrganisationsSearch.by_keyword(params[:keyword])
    end

    #clear temple table and save result into temple table
    OrganisationSearchGrid.find_all_by_login_account_id(session[:user]).each do |i|
      i.destroy
    end

    @organisations.each do |organisation|
      @osg = OrganisationSearchGrid.new
      @osg.login_account_id = session[:user]
      @osg.grid_object_id = organisation.id
      @osg.field_1 = organisation.trading_as
      @osg.field_2 = organisation.registered_name
      @osg.field_3 = organisation.primary_address.first_line unless organisation.primary_address.blank?
      @osg.field_4 = organisation.primary_phone.value unless organisation.primary_phone.blank?
      @osg.field_5 = organisation.primary_website.address unless organisation.primary_website.blank?
      @osg.save
    end
    respond_to do |format|
      format.html
    end
  end

  def show_industrial_code
    @industrial_sector = IndustrySector.find(params[:industrial_id])
    @industrial_code = @industrial_sector.description
    respond_to do |format|
      format.js
    end
  end

  def show_sub_category
    @business_category = BusinessCategory.find(params[:sub_category_id])
    @business_sub_category = @business_category.description

    respond_to do |format|
      format.js
    end
  end

  def show_list
    #org show
    # @list_header = ListHeader.find(session[:current_org_list_id])
    # @organisations = @list_header.entity_on_list.uniq
    @active_tab = params[:active_tab]
    @active_sub_tab = params[:active_sub_tab]
    @current_operation = params[:current_operation]
    session[:active_tab]= params[:active_tab]
    session[:active_sub_tab] = params[:active_sub_tab]
    session[:current_operation] = params[:current_operation]
    respond_to do |format|
      format.js
    end
  end

  #organisation grid show left part
  def show_left
    params[:organisation_id] =  params[:param1] if params[:param1]
    params[:current_operation]= session[:current_operation]

    @list_headers = @current_user.all_organisation_lists
    @list_header = ListHeader.find(session[:current_org_list_id])

    params[:id] = params[:organisation_id] unless (params[:organisation_id].nil? || params[:organisation_id].empty?)
    @super_admin = (@current_user.class.to_s == "SuperAdmin" || @current_user.class.to_s == "MemberZone") ? true : false
    @o = @list_header.entity_on_list.uniq
    @organisation = Organisation.find(params[:id].to_i) rescue @organisation = @o[0]
    @organisation = @o[0] if (@organisation.nil? || !@o.include?(@organisation))
    session[:current_organisation_id] = @organisation.id
    session[:current_org_list_id] = @list_header.id
    #    @active_tab = params[:active_tab]
    #    @active_sub_tab = params[:active_sub_tab]
    @active_tab = session[:active_tab]
    @active_sub_tab = session[:active_sub_tab]
    @client_setup = ClientSetup.first
    @check_field = Array.new

    @organisational_duplication_formula = OrganisationalDuplicationFormula.applied_setting
    unless @organisational_duplication_formula.nil?
      @organisational_duplication_formula.duplication_formula_details.each do |i|
        @check_field << i.field_name
      end
    end

    if(params[:current_operation] == "edit_organisation_list")
      @address = Address.new
      @phone = Phone.new
      @email = Email.new
      @fax = Fax.new
      @website = Website.new
      @instant_messaging = InstantMessaging.new
      @image = @organisation.image unless (@organisation.nil? || @organisation.image.nil?)
      @current_action = "edit"
      render 'show_edit_left.js'
    else
      @primary_phone = @organisation.primary_phone
      @primary_email = @organisation.primary_email
      @primary_fax = @organisation.primary_fax
      @primary_website = @organisation.primary_website
      @primary_address = @organisation.primary_address
      @current_action = "show"
      render 'show_left.js'
    end
  end

  def check_duplication
    @organisational_duplication_formula = OrganisationalDuplicationFormula.applied_setting
    duplication_value = ""
    unless @organisational_duplication_formula.nil?
      @organisational_duplication_formula.duplication_formula_details.each do |i|
        if i.is_foreign_key
          unless i.field_name.camelize.constantize.find(params[i.field_name.to_sym]).nil?
            duplication_value << i.field_name.camelize.constantize.find(params[i.field_name.to_sym]).name[0, i.number_of_charecter]
          end
        else
          duplication_value += params[i.field_name.to_sym][0, i.number_of_charecter]
        end
      end

      @organisation_id = "" #organisation edit
      if (params[:id]!="")
        @organisation_id = params[:id]
        @dup_organisations = Organisation.find(:all, :conditions => ["duplication_value ILIKE ? AND id != ?", duplication_value, params[:id]])
      else
        @dup_organisations = Organisation.find(:all, :conditions => ["duplication_value ILIKE ?", duplication_value])
      end

      unless @dup_organisations.empty?
        #clear temple table and save result into temple table
        DuplicationOrganisationsGrid.find_all_by_login_account_id(session[:user]).each do |i|
          i.destroy
        end

        @dup_organisations.each do |dup_organisation|
          @dog = DuplicationOrganisationsGrid.new
          @dog.login_account_id = session[:user]
          @dog.grid_object_id = dup_organisation.id
          @dog.field_1 = dup_organisation.full_name
          @dog.field_2 = dup_organisation.registered_name
          @dog.field_3 = dup_organisation.trading_as
          @dog.save
        end
      end
    end

    respond_to do |format|
      format.js
    end
  end

  def lookup
    @update_field = params[:update_field]
    ShowOrganisationListGrid.find_all_by_login_account_id(session[:user]).each do |i|
      i.destroy
    end
    @organisations = Organisation.find(:all, :order => "id")
    @organisations.each do |organisations|
      @solg = ShowOrganisationListGrid.new
      @solg.login_account_id = session[:user]
      @solg.grid_object_id = organisations.id
      @solg.field_1 = organisations.full_name
      @solg.field_2 = organisations.short_name
      @solg.field_3 = organisations.primary_address.first_line unless organisations.primary_address.blank?
      @solg.field_4 = organisations.primary_phone.value unless organisations.primary_phone.blank?
      @solg.field_5 = organisations.primary_email.address unless organisations.primary_email.blank?
      @solg.save
    end
    respond_to do |format|
      format.js
    end
  end

  def lookup_fill
    @update_field = params[:update_field]
    @organisation = Organisation.find(params[:id].to_i)
    respond_to do |format|
      format.js
    end
  end

  def general_show_list

    @organisations = Organisation.find(params[:person_id]) rescue @person = Person.find(session[:current_organisation_id])
    @list_header = ListHeader.find(session[:current_org_list_id])
    @o = Array.new
    @o = @list_header.entity_on_list

    ShowOrganisationListGrid.find_all_by_login_account_id(session[:user]).each do |i|
      i.destroy
    end

    @o.each do |organisations|
      @solg = ShowOrganisationListGrid.new
      @solg.login_account_id = session[:user]
      @solg.grid_object_id = organisations.id
      @solg.field_1 = organisations.full_name
      @solg.field_2 = organisations.short_name
      @solg.field_3 = organisations.primary_address.first_line unless organisations.primary_address.blank?
      @solg.field_4 = organisations.primary_phone.value unless organisations.primary_phone.blank?
      @solg.field_5 = organisations.primary_email.address unless organisations.primary_email.blank?
      @solg.save
    end

    @current_operation = params[:current_operation]
    respond_to do |format|
      format.js
    end
  end


  def org_general_name_show

    @organisation = Organisation.find(params[:organisation_id]) rescue @organisation = Organisation.new
    @organisation = Organisation.new if @organisation.nil?  #handle the situation when @organisation return nil
    @update_field = params[:update_field]# for name field updating
    @input_field = params[:input_field]  #to clear the input field


    respond_to do |format|
      format.js
    end
  end

  def org_relationship_name_show

    @organisation = Organisation.find(params[:organisation_id]) rescue @organisation = Organisation.new
    @organisation = Organisation.new if @organisation.nil?  #handle the situation when @organisation return nil
    @update_field = params[:update_field]# for name field updating
    @input_field = params[:input_field]  #to clear the input field
    if !@organisation.organisation_as_source.blank? || !@organisation.organisation_as_related.blank?
      flash.now[:error] = "Some Relationships of This Organisation Exist. Please Remove The Existing Relationship Before Adding A New One."
    end
    respond_to do |format|
      format.js
    end
  end

  def check_level_change
    @organisation = Organisation.find(params[:organisation_id])
    if @organisation.level != params[:organisation_level].to_i
      @source=OrganisationRelationship.find_by_source_organisation_id(@organisation.id)
      @related=OrganisationRelationship.find_by_related_organisation_id(@organisation.id)
    end


    respond_to do |format|
      format.js
    end
  end


  def destroy

    @organisation = Organisation.find(params[:id])
    @organisation.to_be_removed = @organisation.to_be_removed ? false :true
    @organisation.save

    respond_to do |format|
      format.js
    end
  end



  def change_status
    @organisation = Organisation.find(params[:param1])
    @organisation.status = @organisation.status ? false : true
    @organisation.save
    respond_to do |format|

      format.js
    end
  end


  def show_album

    respond_to do |format|

      format.js
    end
  end

  def show_grid
    @organisation = Organisation.find(session[:current_organisation_id])
    @list_header = ListHeader.find(session[:current_list_id])

    #    @render_page = params[:render_page]
    #    @field = params[:field]
    respond_to do |format|
      format.js
    end
  end

  def organisation_treeview
    @organisation = Organisation.find(params[:id])
    @level = @organisation.level
    @current_organisation = @organisation
    @level_array = Array.new
    i = @level
    while i >= 0
      @level_array[i] = []
      @level_array[i][0]= i  # use for level_i
      @level_array[i][1] = @current_organisation.try(:family_id) == 1 ? ClientSetup.send("client_label_#{i}") : ClientSetup.send("label_#{i}")
      @level_array[i][2] = "#{@current_organisation.id} - #{@current_organisation.full_name}"
      @level_array[i][3] = "<a href='#' onclick=';return false;' class='organisation_relationship_reset' use='profile_show' grid_object_id='#{@current_organisation.source_organisations.try(:first).try(:id) if @level!=0}'><img src='/images/Reselect.png' alt='Reset'/></a>"
      @current_organisation = @current_organisation.source_organisations.first
      i-=1
    end

    respond_to do |format|
      format.js
    end
  end


end
