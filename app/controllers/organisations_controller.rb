class OrganisationsController < ApplicationController

  before_filter :check_authentication

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
    @primary_employment = @organisation.primary_employment
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

  def name_finder
    @organisation = Organisation.find(params[:organisation_id]) rescue @organisation = nil
    @employment = Employment.find(params[:employment_id]) rescue @employment = Employment.new
    respond_to do |format|
      format.js {  }
    end
  end

end
