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

  def available_modules
    @available_modules = AvailableModule.find(:all, :order => "name")
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
      @client_setup.primary_password = params[:primary_password]
      @client_setup.secondary_password = params[:secondary_password]
      @client_setup.save
      redirect_to super_admin_client_setups_path
    else
      redirect_to parameters_client_setups_path
    end
  end

  def system_log

    @system_log_entries = SystemLog.find(:all, :order => "created_at DESC")
    SystemLogSearchGrid.find_all_by_login_account_id(session[:user]).each do |i|
      i.destroy
    end

    @system_log_entries.each do |log_entry|
      @slsg = SystemLogSearchGrid.new
      @slsg.login_account_id = session[:user]
      @slsg.grid_object_id = log_entry.id
      @slsg.field_1 = log_entry.created_at.strftime('%a %d %b %Y %H:%M:%S')
      @slsg.field_2 = "#{log_entry.login_account.user_name} - (#{log_entry.login_account.person.name})"
      @slsg.field_3 = log_entry.ip_address
      @slsg.field_4 = log_entry.controller
      @slsg.field_5 = log_entry.action
      @slsg.field_6 = log_entry.message
      @slsg.save
    end

  end
  
end
