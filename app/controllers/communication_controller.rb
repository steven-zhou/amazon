class CommunicationController < ApplicationController


  def email
    @list_headers = @current_user.all_person_lists
    @message_templates = EmailTemplate.active_record
    @message_template = EmailTemplate.new
  end


  def new_message_template
    @message_template = params[:param1] == "person" ? PersonEmailTemplate.new : OrganisationEmailTemplate.new
    @type = params[:param1]
    @table_attributes = TableMetaMetaType.table_categroy(@type)
    @prefix_table_value = (params[:param1]== "person")? "@people." : "@organisations."
    respond_to do |format|
      format.js
    end
  end

  def create_message_template
    @message_template = (params[:type]+"_email_template").camelize.constantize.new(params[:message_template])
    @type = params[:type]
    @model_type = (params[:type]+"_email_template").camelize
    if @mail_template.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new email template with ID #{@message_template.id}.")
    else
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to create a new email template.")
      #----------------------------presence - of--------------------
      if(!@message_template.errors[:name].nil? && @message_template.errors.on(:name).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
      else
        flash.now[:error] = "A record with same name already exists, please try other name"
      end
    end

    respond_to do |format|
      format.js
    end
  end

  def update_message_template
    @message_template = EmailTemplate.find(params[:id])
    if @message_template.update_attributes(params[:message_template])
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated a new Email template with ID #{@message_template.id}.")
    else
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to update a Email template #{@message_template.id}.")
      if(!@message_template.errors[:name].nil?)
        flash.now[:error] = "A Template With That Name Already Exists"
      end
    end

    @message_template = MessageTemplate.find(params[:id])
    if @message_template.update_attributes(params[:message_template])
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated the details for Email Template with ID #{@message_template.id}.")
    else
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to update a Email Template record.")
      #----------------------------presence - of------------------
      if(!@message_template.errors[:name].nil? && @message_template.errors.on(:name).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
      else
        flash.now[:error] = "A record with same name already exists, please try other name"
      end

    end
    @type = params[:type]
    @model_type = (params[:type]+"_email_template").camelize

    respond_to do |format|
      format.js
    end
  end

  def edit_message_template
    @message_template = MessageTemplate.find(params[:id])
    @type = params[:params2]
    @table_attributes = TableMetaMetaType.table_categroy(@type)
    @prefix_table_value = (params[:params2]== "person")? "@people." : "@organisations."
    respond_to do |format|
      format.js
    end
  end

  def destroy_message_template
    @message_template = MessageTemplate.find(params[:id])
    @message_template.to_be_removed = true
    @message_template.save
    @type = (@message_template.class.to_s == "PersonEmailTemplate")? "person" : "organisation"
    @model_type = (@type+"_email_template").camelize
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted Mail Template ID #{@message_template.id}.")
    respond_to do |format|
      format.js
    end
  end

  def retrieve_message_template
    @message_template = MessageTemplate.find(params[:id])
    @message_template.to_be_removed = false
    @message_template.save
    @type = (@message_template.class.to_s == "PersonEmailTemplate")? "person" : "organisation"
    @model_type = (@type+"_email_template").camelize
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) retrieve Mail Template ID #{@message_template.id}.")
    respond_to do |format|
      format.js
    end
  end

  
  def send_email

    @list_headers = @current_user.all_person_lists
    @message_templates = EmailTemplate.active_record
    @message_template = EmailTemplate.new

    subject = params[:email][:subject]
    message_template = EmailTemplate.find(params[:message_template_id])
    list_header = ListHeader.find(params[:list_header_id])

    flash.now[:message] = flash_message(:message => "Your Email Has Been Scheduled For Dispatch And Will Be Sent Soon")
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) send an email with subject #{subject} to list header id #{list_header.id}.")

    for person in list_header.entity_on_list do

      message = message_template.body
      message = message.gsub(/#first_name#/, "#{person.first_name}")
      message = message.gsub(/#last_name#/, "#{person.family_name}")

      email = BulkEmail.new(:subject => subject, :from => "feedback@memberzone.com.au", :to => person.primary_email.value, :body => message) unless person.primary_email.nil?
      email.save unless person.primary_email.nil?

    end

    respond_to do |format|
      format.js
    end

  end

  def search_email
    #    start_date = ((!params[:start_date].nil? && !params[:start_date].empty?) ? params[:start_date].to_date.strftime('%Y-%m-%d') : '0001-01-01 00:00:01')
    #    end_date = ((!params[:end_date].nil? && !params[:end_date].empty?) ? params[:end_date].to_date.strftime('%Y-%m-%d') : '9999-12-31 23:59:59')
    #    tbr = (params[:to_be_removed].nil? || params[:to_be_removed].empty?) ? false : true
    #    dd = (params[:dispatch_date].nil? || params[:dispatch_date].empty?) ? false : true
    #    status = (params[:status].nil? || params[:status].empty?) ? false : true
    #    query_string = dd ? "dispatch_date IS NOT NULL " : "dispatch_date IS NULL "
    #
    #    @emails = BulkEmail.find(:all, :conditions => ["#{query_string} AND created_at >= ? AND created_at <= ? AND to_be_removed = ? AND status = ?", start_date, end_date, tbr, status])
    #
    #    EmailSearchGrid.find_all_by_login_account_id(session[:user]).each do |i|
    #      i.destroy
    #    end
    #
    #    @emails.each do |email|
    #      @esg = EmailSearchGrid.new
    #      @esg.login_account_id = session[:user]
    #      @esg.grid_object_id = email.id
    #      @esg.field_1 = email.to
    #      @esg.field_2 = email.subject
    #      @esg.field_3 = email.created_at.strftime('%a %d %b %Y %H:%M:%S')
    #      @esg.field_4 = (email.dispatch_date.nil? ? "Not Dispatched" : "#{email.dispatch_date.strftime('%a %d %b %Y %H:%M:%S')}")
    #      @esg.field_5 = (email.to_be_removed? ? "True" : "False")
    #      @esg.field_6 = (email.status? ? "Active" : "Inactive")
    #      @esg.save
    #    end


    params[:start_date] ||= "01-01-#{Date.today().year().to_s}"
    params[:end_date] ||= "31-12-#{Date.today().year().to_s}"
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    @tbr = (params[:to_be_removed].nil? || params[:to_be_removed].empty?) ? false : true
    @dd = (params[:dispatch_date].nil? || params[:dispatch_date].empty?) ? false : true
    @status = (params[:status].nil? || params[:status].empty?) ? false : true
    query_string = @dd ? "dispatch_date IS NOT NULL " : "dispatch_date IS NULL "

    date_regex = /^(((0[1-9]|[12]\d|3[01])\-(0[13578]|1[02])\-((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)\-(0[13456789]|1[012])\-((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])\-02\-((19|[2-9]\d)\d{2}))|(29\-02\-((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$/
    if !(@start_date =~ date_regex).nil? && !(@end_date =~ date_regex).nil?
      @date_valid = true
      @count = BulkEmail.count(:all, :conditions => ["created_at >= ? AND created_at <= ? AND to_be_removed = ? AND status = ? AND #{query_string}", @start_date.to_date, @end_date.to_date, @tbr, @status])
    else
      @date_valid = false
      flash.now[:error] = "Please make sure the start date and end date are entered in valid format (dd-mm-yyyy)"
    end    
    respond_to do |format|
      format.js
    end
  end

  def show_email

    @email = BulkEmail.find(params[:grid_object_id])
    
    respond_to do |format|
      format.js
    end

  end


  def modify_email

    #    start_date = ((!params[:modify_email_start_date].nil? && !params[:modify_email_start_date].empty?) ? params[:modify_email_start_date].to_date.strftime('%Y-%m-%d') : '0001-01-01 00:00:01')
    #    end_date = ((!params[:modify_email_end_date].nil? && !params[:modify_email_end_date].empty?) ? params[:modify_email_end_date].to_date.strftime('%Y-%m-%d') : '9999-12-31 23:59:59')
    #    tbr = params[:modify_email_to_be_removed] == "true" ? true : false
    #    dd = params[:modify_email_dispatch_date] == "true" ? true : false
    #    status = params[:modify_email_status] == "true" ? true : false

    update_tbr = params[:email][:to_be_removed].to_i == 0 ? false : true 
    update_status = params[:email][:status].to_i == 0 ? false : true
    update_dd = params[:email][:dispatch_date].to_i == 0 ? false : true
    @email = BulkEmail.find(params[:id])
    if update_dd
      @email.dispatch_date = @email.dispatch_date.nil? ? Time.now() : @email.dispatch_date
    else
      @email.dispatch_date = nil
    end
    @email.status = update_status
    @email.to_be_removed = update_tbr
    @email.save
    flash[:message] = flash_message(:type => 'object_updated_successfully', :object => 'email')

    respond_to do |format|
      format.js
    end

  end

  def page_initial
    @render_page = params[:render_page]
    @field = params[:field]
    @list_headers = @current_user.all_person_lists
    @message_templates = EmailTemplate.active_record
    @message_template = EmailTemplate.new
    @start_date = "#{Date.today().at_beginning_of_week.strftime('%Y-%m-%d')}"
    @end_date = "#{Date.today().strftime('%Y-%m-%d')}"
    respond_to do |format|
      format.js
    end
  end

  def template_page_initial
    @render_page = params[:render_page]
    @field = params[:field]
    @list_headers = @current_user.all_person_lists
    @message_templates = EmailTemplate.find(:all)
    @message_template = EmailTemplate.new

    #for the email history using
    @start_date = "#{Date.today().at_beginning_of_week.strftime('%d-%m-%Y')}"
    
    @end_date = "#{Date.today().strftime('%d-%m-%Y')}"

    if @field == "email_maintenance_page"
      -#@count = TransactionHeader.count(:all, :conditions => ["entity_id=? and entity_type=? and banked=? and transaction_date >= ? and transaction_date <= ?", session[:entity_id], session[:entity_type], true, @start_date.to_date, @end_date.to_date])
      @count = BulkEmail.count(:all, :conditions=>["created_at >= ? and created_at <= ?", @start_date.to_date, @end_date.to_date])
      @tbr = false
      @dd = false
      @status = true
    end
    respond_to do |format|
      format.js
    end
  end

  def person_mail_merge
    @entity_list_headers = @current_user.all_person_lists
    @entity_query_headers = PersonQueryHeader.saved_queries
    @mail_templates = PersonMailTemplate.active_record
    @entity_type = "person"
  end
  
  def organisation_mail_merge
    @entity_list_headers = @current_user.all_organisation_lists
    @entity_query_headers = OrganisationQueryHeader.saved_queries
    @mail_templates = OrganisationMailTemplate.active_record
    @entity_type = "organisation"
  end

  def person_email_merge
    @entity_list_headers = @current_user.all_person_lists
    @entity_query_headers = PersonQueryHeader.saved_queries
    @mail_templates = PersonEmailTemplate.active_record
    @entity_type = "person"

  end

  def organisation_email_merge
    @entity_list_headers = @current_user.all_organisation_lists
    @entity_query_headers = OrganisationQueryHeader.saved_queries
    @mail_templates = OrganisationEmailTemplate.active_record
    @entity_type = "organisation"
  end
end
