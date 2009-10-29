class ClientSetupsController < ApplicationController

  def parameters
    @client_setup = ClientSetup.first
    respond_to do |format|
      format.html
    end
  end

  def license_info
    @client_setup = ClientSetup.first
    @client_organisation = @client_setup.client_organisation
    respond_to do |format|
      format.html
    end
  end

  def client_organisation
    @client_setup = ClientSetup.first
    @client_organisation = @client_setup.client_organisation
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

  def installation
    @client_setup = ClientSetup.first
    @client_organisation = @client_setup.client_organisation
    respond_to do |format|
      format.html
    end
  end

  def modules
    @client_setup = ClientSetup.first
    respond_to do |format|
      format.html
    end
  end

  def super_admin
    @client_setup = ClientSetup.first
    respond_to do |format|
      format.html
    end
  end

  def update
    @client_setup = ClientSetup.first
    if @client_setup.update_attributes(params[:client_setup])
      flash[:message] = "Client Setup is updated"
    end

    if params[:installation]
      redirect_to installation_client_setups_path
    elsif
      params[:super_admin]
      redirect_to super_admin_client_setups_path
    else
      redirect_to parameters_client_setups_path
    end
  end
end
