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
  end

  def search_system_log

    user_name = ((!params[:user_name].nil? && !params[:user_name].empty?) ? params[:user_name] : '%%')
    start_date = ((!params[:start_date].nil? && !params[:start_date].empty?) ? params[:start_date].to_date.strftime('%Y-%m-%d') : '0001-01-01 00:00:01')
    end_date = ((!params[:end_date].nil? && !params[:end_date].empty?) ? params[:end_date].to_date.strftime('%Y-%m-%d') : '9999-12-31 23:59:59')

    @system_log_entries = SystemLog.find_by_sql(["SELECT s.id AS \"id\", s.created_at AS \"created_at\", s.login_account_id AS \"login_account_id\", s.ip_address AS \"ip_address\", s.message AS \"message\" FROM system_logs s, login_accounts l WHERE s.login_account_id = l.id AND l.user_name LIKE ? AND s.created_at >= ? AND s.created_at <= ? ORDER BY s.created_at ASC", user_name, start_date, end_date])
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
      @slsg.field_4 = log_entry.message
      @slsg.save
    end

    respond_to do |format|
      format.js
    end


  end
  
end
