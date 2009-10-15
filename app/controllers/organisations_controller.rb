class OrganisationsController < ApplicationController

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
    @postcodes = DomesticPostcode.find(:all)
    respond_to do |format|
      format.html
    end
  end

  def show
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
    end
  end

  def create
    @organisation = Organisation.new(params[:organisation])
    @organisation.onrecord_since = Date.today()
    if @organisation.save
      if !params[:image].nil?
        @image = Image.new(params[:image])
        if @image.save
          @organisation.image = @image
        else
          flash.now[:warning] = "The image was not saved."
        end
      end

      # If the user wants to edit the record they just added
      if(params[:edit])
        flash.now[:message] = "Sucessfully added ##{@organisation.id} - #{@organisation.full_name}"
        redirect_to edit_organisation_path(@organisation)
        # If the user wants to continue adding records
      else
        flash.now[:message] = "Sucessfully added ##{@organisation.id} - #{@organisation.full_name} (<a href=#{edit_organisation_path(@organisation)}>edit details</a>)"
        redirect_to new_organisation_path
      end
    else
      @organisation.addresses.build(params[:organisation][:addresses_attributes][0]) if @organisation.addresses.empty?
      @organisation.phones.build(params[:organisation][:phones_attributes][0]) if @organisation.phones.empty?
      @organisation.emails.build(params[:organisation][:emails_attributes][0]) if @organisation.emails.empty?
      @organisation.websites.build(params[:organisation][:websites_attributes][0]) if @organisation.websites.empty?
      @postcodes = DomesticPostcode.find(:all)
      #flash.now[:error] = flash_message(:type => "field_missing", :field => "Full name")if (!@organisation.errors[:full_name].nil? && @organisation.errors.on(:full_name).include?("can't be blank"))
      flash.now[:warning] = "There was an error creating a new organisation profile. Please check you entered a full name."
      render :action =>'new'
    end
  end

  def edit
    @o = Organisation.find(:all, :order => "id")
    @postcodes = DomesticPostcode.find(:all)
    params[:id] = params[:organisation_id] unless (params[:organisation_id].nil? || params[:organisation_id].empty?)
    @organisation = Organisation.find(params[:id].to_i) rescue @organisation = @o[0]
    @address = Address.new
    @phone = Phone.new
    @email = Email.new
    @fax = Fax.new
    @website = Website.new
    @masterdoc = MasterDoc.new
    @note = Note.new
    @image = @organisation.image unless (@organisation.nil? || @organisation.image.nil?)
    respond_to do |format|
      format.html
    end
  end

  def update

    @organisation = Organisation.find(params[:id])
    Image.transaction do
      unless params[:image].nil?
        @image = Image.new(params[:image])
        if @image.save
          @organisation.image.destroy unless @organisation.image.nil?
          @organisation.image = @image
        else
          flash.now[:warning] = "The image was not saved. Please check that file was a valid image file."
        end
      end
    end

    @organisation.update_attributes(params[:organisation])
    flash.now[:warning] = "There was an error updating the person's details." unless @organisation.save


    flash.now[:message] = "#{@organisation.full_name}'s information was updated successfully." unless !flash[:warning].nil?
    if(params[:edit])
      redirect_to edit_organisation_path(@organisation)
    else
      redirect_to organisation_path(@organisation)
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

  def add_keywords
    @organisation = Organisation.find(params[:id])

    unless params[:add_keywords].nil?
      params[:add_keywords].each do |keyword_id|
        keyword = Keyword.find(keyword_id);
        @organisation.keywords<<keyword
      end
    end
    render "add_keywords.js"
  end

  def remove_keywords
    @organisation = Organisation.find(params[:id])

    unless params[:remove_keywords].nil?
      params[:remove_keywords].each do |keyword_id|
        keyword = Keyword.find(keyword_id)
        @organisation.keywords.delete(keyword)
      end
    end
    render "remove_keywords.js"
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


    if(params[:current_operation] == "edit_organisation_list")
      render 'show_edit_left.js'
     
    else
     
      respond_to do |format|
        format.js
      end
    end
    #     respond_to do |format|
    #      format.js
    #    end
  end
end
