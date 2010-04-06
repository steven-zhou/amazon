class ClientSetupsController < ApplicationController

  #System Logging added

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

  def organisation_structure
    @client_setup = ClientSetup.first
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
    @available_modules = AvailableModule.all
    respond_to do |format|
      format.html
    end
  end

  def super_admin
    @client_setup = ClientSetup.first
    @login_account = SuperAdmin.first
    respond_to do |format|
      format.html
    end
  end

  def member_zone
    @client_setup = ClientSetup.first
    respond_to do |format|
      format.html
    end
  end

  def feedback_list
    @feedback = FeedbackItem.all

    #clear temple table and save result into temple table
    FeedbackSearchGrid.find_all_by_login_account_id(session[:user]).each do |i|
      i.destroy
    end

    @feedback.each do |feedback|
      @psg = FeedbackSearchGrid.new
      @psg.login_account_id = session[:user]
      @psg.grid_object_id = feedback.id
      @psg.field_1 = feedback.feedback_date.strftime('%a %d %b %Y')
      @psg.field_2 = feedback.submitted_by
      @psg.field_3 = feedback.subject
      @psg.field_4 = feedback.ip_address
      @psg.field_5 = feedback.status
      @psg.save
    end
    respond_to do |format|
      format.html
    end
  end

  def update
    @client_setup = ClientSetup.first


    check_installation_date = params[:client_setup][:installation_date].blank? ? true : valid_date(params[:client_setup][:installation_date])
    check_halt_date = params[:client_setup][:halt_date].blank? ? true : valid_date(params[:client_setup][:halt_date])
    check_birthday_date = params[:client_setup][:date_of_birth].blank? ? true : valid_date(params[:client_setup][:date_of_birth])
    if check_installation_date&&check_halt_date&&check_birthday_date
      if params[:parameters]
        label_has_gap = nil

        i = 9
        while i >= 0
          if label_has_gap.nil?
            # We've started moving from the bottom up
            # We leave the value to be nil until we run into a filled value, when we become false
            label_has_gap = params[:client_setup]["level_#{i}_label".to_sym].empty? ? nil : false
          elsif !label_has_gap
            # If we have not run into a gap so far, but have run into text
            # If we run into some empty space we have a gap
            label_has_gap = params[:client_setup]["level_#{i}_label".to_sym].empty? ? true : false
          end
          i-=1
        end

        label_has_gap = false if label_has_gap.nil?

        flash[:error] = "You Cannot Have A Gap Between Organisational Hierarchies." if label_has_gap


        # Check to ensure each remark was filled in with a label
        # Check there were no duplicate labels

        labels = Hash.new

        i = 0
        while i < 9
          flash[:error] = "A Remark Was Filled In Without A Label." if check_for_label_without_remark(params[:client_setup]["level_#{i}_label".to_sym], params[:client_setup]["level_#{i}_remarks".to_sym])
          label = params[:client_setup]["level_#{i}_label".to_sym].downcase
          labels["#{label}"] = labels["#{label}"].nil? ? 1 : (labels["#{label}"] + 1) unless label.empty?
          i += 1
        end

        for key in labels.keys
          flash[:error] = "You Have a Duplicate Label. All Labels Must Be Unique." if labels["#{key}"] > 1
        end
      end

      if (params[:password] && params[:password] != params[:repeat_password])
        flash[:error] = "Passwords are not matched each other. Please try again."
      elsif (@client_setup.update_attributes(params[:client_setup]) && flash[:error].nil?)
        system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated Client Setup with ID #{@client_setup.id}.")
        flash[:message] = "Client Setup is updated"
      end


    else
      flash[:error] = "Please make sure the start date and end date are entered in valid format (dd-mm-yyyy)"
    end


    if params[:installation]
      redirect_to installation_client_setups_path
    elsif
      params[:super_admin]
      @client_setup.super_admin_power_password = params[:password]
      @client_setup.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated Client Setup with ID #{@client_setup.id}.")
      redirect_to super_admin_client_setups_path
    elsif
      params[:member_zone]
      @client_setup.member_zone_power_password = params[:password]
      @client_setup.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated Client Setup with ID #{@client_setup.id}.")
      redirect_to member_zone_client_setups_path
    elsif
      params[:parameters]
      redirect_to parameters_client_setups_path
    else
      redirect_to organisation_structure_client_setups_path
    end
  end

  def system_log_management
  end

  def search_system_log

    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) searched System Log entries.")


    @query=""

    if (params[:start_date].blank? || params[:end_date].blank? )
      params[:start_date]= '01-01-1909' if params[:start_date].blank?
      params[:end_date] = '12-31-2599' if params[:end_date].blank?
         
      if valid_date(params[:start_date]) && valid_date(params[:end_date])
        @start_date=params[:start_date]
        @end_date=params[:end_date]
      else
        flash.now[:error] = "Please make sure the start date and end date are entered in valid format (dd-mm-yyyy)"
      end
    else


      if valid_date(params[:start_date]) && valid_date(params[:end_date])

  
        @start_date = ((!params[:start_date].nil? && !params[:start_date].empty?) ? params[:start_date].to_date.strftime('%Y-%m-%d') : '0001-01-01 00:00:01')
        @end_date = ((!params[:end_date].nil? && !params[:end_date].empty?) ? params[:end_date].to_date.strftime('%Y-%m-%d') : '9999-12-31 23:59:59')
      else
        flash.now[:error] = "Please make sure the start date and end date are entered in valid format (dd-mm-yyyy)"
      end
    
    end

    if flash.now[:error].nil?
      @query << "start_date="+@start_date+"&end_date="+@end_date
    end



    @user_name = ((!params[:user_name].nil? && !params[:user_name].empty?) ? params[:user_name] : '')
    unless @user_name.empty?

      @query << "&user_name="+@user_name
    end

    @status = ((!params[:status].nil? && !params[:status].empty?) ? params[:status] : '')
    unless @status.empty?
      @query << "&status="+@status
    end
    # controller = ((!params[:log_controller].nil? && !params[:log_controller].empty?) ? params[:log_controller] : '%%')
    # action = ((!params[:log_action].nil? && !params[:log_action].empty?) ? params[:log_action] : '%%')


    respond_to do |format|
      format.js
    end


  end

  def archive_system_log

    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) searched System Log entries for achiving.")

    if (params[:start_date].blank? || params[:end_date].blank?)
      start_date= '0001-01-01 00:00:01'
      end_date = '9999-12-31 23:59:59'
    else


      if valid_date(params[:start_date]) && valid_date(params[:end_date])
        start_date = ((!params[:start_date].nil? && !params[:start_date].empty?) ? params[:start_date].to_date.strftime('%Y-%m-%d') : '0001-01-01 00:00:01')
        end_date = ((!params[:end_date].nil? && !params[:end_date].empty?) ? params[:end_date].to_date.strftime('%Y-%m-%d') : '9999-12-31 23:59:59')
      else
        flash[:error] = "Please make sure the start date and end date are entered in valid format (dd-mm-yyyy)"
      end
    end

    user_name = ((!params[:archive_user_name].nil? && !params[:archive_user_name].empty?) ? params[:archive_user_name] : '%%')
    
    status = 'Live'

    @system_log_entries = SystemLog.system_log_entries(user_name, start_date, end_date.to_date.tomorrow, status)
    SystemLogArchiveGrid.find_all_by_login_account_id(session[:user]).each do |i|
      i.destroy
    end

    @system_log_entries.each do |log_entry|
      @slsg = SystemLogArchiveGrid.new
      @slsg.login_account_id = session[:user]
      @slsg.grid_object_id = log_entry.id
      @slsg.field_1 = log_entry.created_at.getlocal.strftime('%a %d %b %Y %H:%M:%S')
      @slsg.field_2 = (@current_user.class.to_s == "SystemUser")? "#{log_entry.login_account.user_name} - (#{log_entry.login_account.person.name})" : "#{log_entry.login_account.user_name}"
      @slsg.field_3 = "#{log_entry.ip_address}"
      @slsg.field_4 = "#{log_entry.controller}"
      @slsg.field_5 = "#{log_entry.action}"
      @slsg.field_6 = "#{log_entry.message}"
      @slsg.save
    end

    respond_to do |format|
      format.js
    end


  end

  def delete_archive_system_log_entries
   

    user_name = ((!params[:user_name].nil? && !params[:user_name].empty?) ? params[:user_name] : '%%')
    start_date = ((!params[:start_date].nil? && !params[:start_date].empty?) ? params[:start_date].to_date.strftime('%Y-%m-%d') : '0001-01-01 00:00:01')
    end_date = ((!params[:end_date].nil? && !params[:end_date].empty?) ? params[:end_date].to_date.strftime('%Y-%m-%d') : '9999-12-31 23:59:59')
    status = 'Archived'

    @system_log_entries = SystemLog.system_log_entries(user_name, start_date, end_date.to_date.tomorrow, status)
    SystemLogArchiveGrid.find_all_by_login_account_id(session[:user]).each do |i|
      i.destroy
    end

    for entry in @system_log_entries do
      entry.destroy
    end
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) Deleted archived System Log entries.")
    flash[:message] = "The Archived System Log Entries has been deleted"
    redirect_to :action => "system_log_management"


  end












  def archive_system_log_entries

    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) archived System Log entries.")

    user_name = ((!params[:user_name].nil? && !params[:user_name].empty?) ? params[:user_name] : '%%')
    start_date = ((!params[:start_date].nil? && !params[:start_date].empty?) ? params[:start_date].to_date.strftime('%Y-%m-%d') : '0001-01-01 00:00:01')
    end_date = ((!params[:end_date].nil? && !params[:end_date].empty?) ? params[:end_date].to_date.strftime('%Y-%m-%d') : '9999-12-31 23:59:59')
    status = 'Live'

    @system_log_entries = SystemLog.system_log_entries(user_name, start_date, end_date.to_date.tomorrow, status)
    SystemLogArchiveGrid.find_all_by_login_account_id(session[:user]).each do |i|
      i.destroy
    end

    for entry in @system_log_entries do
      entry.status = 'Archived'
      entry.save
    end

    flash[:message] = flash_message(:type => "object_updated_successfully", :object => "System Log")
    redirect_to :action => "system_log_management"

  end


  def system_log_verify_user_name

    login_account = LoginAccount.find_by_user_name(params[:user_name])

    if ( params[:user_name].nil? || params[:user_name].empty? )
      @user_name_result = ""
    elsif (!login_account.nil? && login_account.class.to_s != "SystemUser")
      @user_name_result = "#{params[:user_name]}"
    else
      @user_name_result = login_account.nil? ? "Invalid Username" : login_account.person.name
    end

    respond_to do |format|
      format.js
    end

  end

  def system_log_archive_verify_user_name

    login_account = LoginAccount.find_by_user_name(params[:user_name])

    if ( params[:user_name].nil? || params[:user_name].empty? )
      @user_name_result = ""
    elsif (!login_account.nil? && login_account.class.to_s != "SystemUser")
      @user_name_result = "#{params[:user_name]}"
    else
      @user_name_result = login_account.nil? ? "Invalid Username" : login_account.person.name
    end


    respond_to do |format|
      format.js
    end

  end


  def person_bank_accounts

  end


  def new_person_bank_account
    @person_bank_account = PersonBankAccount.new
    respond_to do |format|
      format.js
    end
  end

  def create_person_bank_account
    @person_bank_account = PersonBankAccount.new(params[:person_bank_account])
    if @person_bank_account.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new person bank account with ID #{@person_bank_account.id}.")
    else
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to create a person bank account.")
      if(!@person_bank_account.errors[:person_bank_id].nil?)
        flash.now[:error] = "Please Select A Bank"
      elsif(!@person_bank_account.errors[:person_person_id].nil?)
        flash.now[:error] = "Please Select A Person"
      elsif(!@person_bank_account.errors[:account_number].nil?)
        flash.now[:error] = "That Account Number Already Exists At That Branch"
      end
    end

    respond_to do |format|
      format.js
    end
  end

  def update_person_bank_account
    @person_bank_account = PersonBankAccount.find(params[:id])
    if @person_bank_account.update_attributes(params[:person_bank_account])
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated a new person bank account with ID #{@person_bank_account.id}.")
    else
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to update a person bank account #{@person_bank_account.id}.")
      if(!@person_bank_account.errors[:person_bank_id].nil?)
        flash.now[:error] = "Please Select A Bank"
      elsif(!@person_bank_account.errors[:person_person_id].nil?)
        flash.now[:error] = "Please Select A Person"
      elsif(!@person_bank_account.errors[:account_number].nil?)
        flash.now[:error] = "That Account Number Already Exists At That Branch"
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def edit_person_bank_account
    @person_bank_account = PersonBankAccount.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def destroy_person_bank_account
    @person_bank_account = PersonBankAccount.find(params[:id])
    @person_bank_account.destroy
    respond_to do |format|
      format.js
    end
  end

  def verify_new_person_bank_account_person_id
    @person = Person.find_by_id(params[:id].to_i)
  end

  def verify_edit_person_bank_account_person_id
    @person = Person.find_by_id(params[:id].to_i)
  end

  def client_bank_accounts

  end


  def new_client_bank_account
    @client_bank_account = ClientBankAccount.new
    respond_to do |format|
      format.js
    end
  end

  def create_client_bank_account
    @client_bank_account = ClientBankAccount.new(params[:client_bank_account])
    @client_bank_account.to_be_removed = false
    if @client_bank_account.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new client bank account with ID #{@client_bank_account.id}.")
    else
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to create a client bank account.")
      if(!@client_bank_account.errors[:client_bank_id].nil?)
        flash.now[:error] = "Please Select A Bank"
      elsif(!@client_bank_account.errors[:account_number].nil?)
        flash.now[:error] = "That Account Number Already Exists At That Branch"
      end
    end


    respond_to do |format|
      format.js
    end
  end

  def update_client_bank_account
    @client_bank_account = ClientBankAccount.find(params[:id])
    if @client_bank_account.update_attributes(params[:client_bank_account])
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated a new client bank account with ID #{@client_bank_account.id}.")
    else
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to update a client bank account #{@client_bank_account.id}.")
      if(!@client_bank_account.errors[:client_bank_id].nil?)
        flash.now[:error] = "Please Select A Bank Account"
      elsif(!@client_bank_account.errors[:account_number].nil?)
        flash.now[:error] = "That Account Number Already Exists At That Branch"
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def edit_client_bank_account
    @client_bank_account = ClientBankAccount.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def destroy_client_bank_account
    @client_bank_account = ClientBankAccount.find(params[:id])
    #    @client_bank_account.destroy
    @client_bank_account.to_be_removed = true
    @client_bank_account.save
    respond_to do |format|
      format.js
    end
  end

  def retrieve_client_bank_account
    @client_bank_account = ClientBankAccount.find(params[:id])
    #    @client_bank_account.destroy
    @client_bank_account.to_be_removed = false
    @client_bank_account.save
    respond_to do |format|
      format.js {render "destroy_client_bank_account.js"}
    end
  end

  def reset_default_label


      i = 0
      @default_label = Array.new
      @id = Array.new
        while i <= 9
          @default_label << ClientSetup.first.__send__("level_#{i}_default_label")
          @id << "client_setup_level_#{i}_label"
          i+=1
        end
      
    respond_to do |format|
      format.js
    end

  end




  private

  def check_for_label_without_remark(label, remark)
    (label.empty? && !remark.empty?) ? true : false
  end

end


