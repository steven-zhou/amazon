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
    respond_to do |format|
      format.html
    end
  end

  def show
    params[:id] = params[:organisation_id] unless (params[:organisation_id].nil? || params[:organisation_id].empty?)
    @organisation = Organisation.find_by_id(params[:id].to_i)
    @organisation = Organisation.new if @organisation.nil?
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
          flash[:warning] = "The image was not saved."
        end
      end

      # If the user wants to edit the record they just added
      if(params[:edit])
        flash[:message] = "Sucessfully added ##{@organisation.id} - #{@organisation.full_name}"
        redirect_to edit_organisation_path(@organisation)
        # If the user wants to continue adding records
      else
        flash[:message] = "Sucessfully added ##{@organisation.id} - #{@organisation.full_name} (<a href=#{edit_organisation_path(@organisation)}>edit details</a>)"
        redirect_to new_organisation_path
      end
    else
      @organisation.addresses.build(params[:person][:addresses_attributes][0]) if @organisation.addresses.empty?
      @organisation.phones.build(params[:person][:phones_attributes][0]) if @organisation.phones.empty?
      @organisation.emails.build(params[:person][:emails_attributes][0]) if @organisation.emails.empty?
      @organisation.faxes.build(params[:person][:faxes_attributes][0]) if @organisation.faxes.empty?
      @organisation.websites.build(params[:person][:websites_attributes][0]) if @organisation.websites.empty?

      flash[:warning] = "There was an error creating a new user profile. Please check you entered a family name."
      render :action =>'new'
    end
  end

  def edit
    params[:id] = params[:organisation_id] unless (params[:organisation_id].nil? || params[:organisation_id].empty?)
    @organisation = Organisation.find(params[:id].to_i) rescue @organisation = Organisation.new(:id => "")
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
          flash[:warning] = "The image was not saved. Please check that file was a valid image file."
        end
      end
    end

    @organisation.update_attributes(params[:organisation])
    flash[:warning] = "There was an error updating the person's details." unless @organisation.save


    flash[:message] = "#{@organisation.full_name}'s information was updated successfully." unless !flash[:warning].nil?
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

    @organisation = Organisation.new
    respond_to do |format|
      format.html
    end
  end

end
