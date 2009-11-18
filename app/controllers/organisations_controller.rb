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
    @image = Image.new
    #@postcodes = DomesticPostcode.find(:all)
    @check_field = Array.new
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

        #get active tabs
        @active_tab = params[:active_tab]
        @active_sub_tab = params[:active_sub_tab]
        
    params[:id] = params[:organisation_id] unless (params[:organisation_id].nil? || params[:organisation_id].empty?)
    @o = Organisation.find(:all, :order => "id")
    @organisation = Organisation.find_by_id(params[:id].to_i)
    @organisation = @o[0] if @organisation.nil?
    @primary_phone = @organisation.primary_phone
    @primary_email = @organisation.primary_email
    @primary_fax = @organisation.primary_fax
    @primary_website = @organisation.primary_website
    @primary_address = @organisation.primary_address
    @other_phones = @organisation.other_phones
    @other_emails = @organisation.other_emails
    @other_faxes = @organisation.other_faxes
    @other_websites = @organisation.other_websites
    @other_addresses = @organisation.other_addresses
    @notes = @organisation.notes
    
    
    OrganisationEmployeeGrid.find_all_by_login_account_id(session[:user]).each do |i|
      i.destroy
    end

    @organisation.employees.each do |organisations_employees|  #show organisation employee grid
      @soeg = OrganisationEmployeeGrid.new
      @soeg.login_account_id = session[:user]
      @soeg.grid_object_id = organisations_employees.id
      @soeg.field_1 = organisations_employees.first_name
      @soeg.field_2 = organisations_employees.family_name
      @soeg.field_3 = organisations_employees.primary_address.first_line unless organisations_employees.primary_address.blank?
      @soeg.field_4 = organisations_employees.primary_phone.value unless organisations_employees.primary_phone.blank?
      @soeg.field_5 = organisations_employees.primary_email.address unless organisations_employees.primary_email.blank?
      @soeg.save
    end
    respond_to do |format|
      format.html
        format.js {render 'show_left.js'}

    end
  end

  def create
    @organisation = (params[:type].camelize.constantize).new(params[:organisation])
    @organisation.onrecord_since = Date.today()
    if @organisation.save
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
      #modified by Tao, remove 'Submit and edit' button
      # If the user wants to edit the record they just added
      #            if(params[:edit])
      #                flash[:message] = "Sucessfully added ##{@organisation.id} - #{@organisation.full_name}"
      #                redirect_to edit_organisation_path(@organisation)
      #                # If the user wants to continue adding records
      #            else
      flash[:message] = "Sucessfully added ##{@organisation.id} - #{@organisation.full_name} (<a href=#{edit_organisation_path(@organisation)} style='color:white'>edit details</a>)"
      redirect_to new_organisation_path
      #            end
    else
      @organisation.addresses.build(params[:organisation][:addresses_attributes][0]) if @organisation.addresses.empty?
      @organisation.phones.build(params[:organisation][:phones_attributes][0]) if @organisation.phones.empty?
      @organisation.emails.build(params[:organisation][:emails_attributes][0]) if @organisation.emails.empty?
      @organisation.websites.build(params[:organisation][:websites_attributes][0]) if @organisation.websites.empty?
      #@postcodes = DomesticPostcode.find(:all)
      flash[:error] = flash_message(:type => "field_missing", :field => "Full name")if (!@organisation.errors[:full_name].nil? && @organisation.errors.on(:full_name).include?("can't be blank"))
#      flash[:warning] = "Organisation Profile Has NOT been Created Due to Data Errors"
      redirect_to new_organisation_path
    end
  end


  def edit

          @active_tab = params[:active_tab]
        @active_sub_tab = params[:active_sub_tab]
    @current_user = LoginAccount.find(session[:user])
    @super_admin = (@current_user.class.to_s == "SuperAdmin" || @current_user.class.to_s == "MemberZone") ? true : false
    @o = Organisation.find(:all, :order => "id")
    #@postcodes = DomesticPostcode.find(:all)
    params[:id] = params[:organisation_id] unless (params[:organisation_id].nil? || params[:organisation_id].empty?)
    @organisation = Organisation.find(params[:id].to_i) rescue @organisation = @o[0]
    @organisation = @o[0] if @organisation.nil?
    @address = Address.new
    @phone = Phone.new
    @email = Email.new
    @fax = Fax.new
    @website = Website.new
    @masterdoc = MasterDoc.new
    @note = Note.new
    @image = @organisation.image unless (@organisation.nil? || @organisation.image.nil?)
    @organisation_group = OrganisationGroup.new
    @check_field = Array.new
    @organisational_duplication_formula = OrganisationalDuplicationFormula.applied_setting
    unless @organisational_duplication_formula.nil?
      @organisational_duplication_formula.duplication_formula_details.each do |i|
        @check_field << i.field_name
      end
    end
    respond_to do |format|
      format.html
      format.js {render 'show_edit_left.js'}
    end
  end

  def update
    @organisation = Organisation.find(params[:id])
    type = @organisation.class.to_s.underscore
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
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated Organisation #{@organisation.id}.")
    flash[:warning] = "Organisation Update Has NOT been Submitted Due to Data Errors" unless @organisation.save


    flash[:message] = "#{@organisation.full_name}'s Details Have been Updated Successfully." unless !flash[:warning].nil?
    #modified by Tao, remove 'Submit and Close' button.
    #if(params[:edit])
    #    redirect_to edit_organisation_path(@organisation)
    #elsif(params[:installation])
    if(params[:installation])
      flash[:message] = "Client Organisation - #{@organisation.full_name}'s information was initialized successfully."
      redirect_to :controller => :client_setups, :action => :client_organisation
    else
      redirect_to edit_organisation_path(@organisation)
      #redirect_to organisation_path(@organisation)
    end
  end

  def name_finder
    @organisation = Organisation.find(params[:organisation_id]) rescue @organisation = nil
    @employment = Employment.find(params[:employment_id]) rescue @employment = Employment.new
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
    @organisations = Organisation.find(:all, :order => "id")
    @active_tab = params[:active_tab]
    @active_sub_tab = params[:active_sub_tab]
    ShowOrganisationListGrid.find_all_by_login_account_id(session[:user]).each do |i|
      i.destroy
    end

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

    @current_operation = params[:current_operation]
    respond_to do |format|
      format.js
    end
  end

  #organisation grid show left part
  def show_left
    params[:id] = params[:organisation_id] unless (params[:organisation_id].nil? || params[:organisation_id].empty?)
    @super_admin = (@current_user.class.to_s == "SuperAdmin" || @current_user.class.to_s == "MemberZone") ? true : false
    @o = Organisation.find(:all, :order => "id")
    @organisation = Organisation.find_by_id(params[:id].to_i)
    @organisation = @o[0] if @organisation.nil?
    @active_tab = params[:active_tab]
    @active_sub_tab = params[:active_sub_tab]
    @check_field = Array.new
    @organisational_duplication_formula = OrganisationalDuplicationFormula.applied_setting
    unless @organisational_duplication_formula.nil?
      @organisational_duplication_formula.duplication_formula_details.each do |i|
        @check_field << i.field_name
      end
    end
    if(params[:current_operation] == "edit_organisation_list")
      #      puts "**********#{@organisation.class.to_s}*********8"
      #@postcodes = DomesticPostcode.find(:all)
      @address = Address.new
      @phone = Phone.new
      @email = Email.new
      @fax = Fax.new
      @website = Website.new
      @masterdoc = MasterDoc.new
      @note = Note.new
      @image = @organisation.image unless (@organisation.nil? || @organisation.image.nil?)
      @organisation_group = OrganisationGroup.new
      @current_action = "edit"
      render 'show_edit_left.js'
     
    else
     
      respond_to do |format|
        @primary_phone = @organisation.primary_phone
        @primary_email = @organisation.primary_email
        @primary_fax = @organisation.primary_fax
        @primary_website = @organisation.primary_website
        @primary_address = @organisation.primary_address
        @other_phones = @organisation.other_phones
        @other_emails = @organisation.other_emails
        @other_faxes = @organisation.other_faxes
        @other_websites = @organisation.other_websites
        @other_addresses = @organisation.other_addresses
        @notes = @organisation.notes
        @current_action = "show"
        format.js
      end
    end
    #     respond_to do |format|
    #      format.js
    #    end
  end

  def check_duplication
    @organisational_duplication_formula = OrganisationalDuplicationFormula.applied_setting
    duplication_value = ""
    unless @organisational_duplication_formula.nil?
      @organisational_duplication_formula.duplication_formula_details.each do |i|
        if i.is_foreign_key
          duplication_value += i.field_name.camelize.constantize.find(params[i.field_name.to_sym]).name[0, i.number_of_charecter]
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

end
