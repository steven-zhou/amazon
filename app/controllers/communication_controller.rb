class CommunicationController < ApplicationController


  def email
    @list_headers = @current_user.all_lists
    @message_templates = MessageTemplate.find(:all)
    @message_template = MessageTemplate.new
  end


  def create_message_template
    @message_template = MessageTemplate.new(params[:message_template])

    if @message_template.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new message template with ID #{@message_template.id}.")
      flash[:message] = flash_message(:type => "object_created_successfully", :object => "message template")
    else
      flash[:error] = flash_message(:message => "A Template Already Exists With That Name")
    end
    respond_to do |format|
      format.js
    end    
  end

  def refresh_template_message_select
    @list_headers = @current_user.all_lists
    @message_templates = MessageTemplate.find(:all)
    respond_to do |format|
      format.js
    end
  end

  def new_message_template
    @message_template = MessageTemplate.new
    respond_to do |format|
      format.js
    end
  end

  def edit_message_template
    @message_template = MessageTemplate.find(params[:id])
    respond_to do |format|
      format.js
    end
  end


  def update_message_template
    @message_template = MessageTemplate.find_by_id(params[:id])
    if @message_template.update_attributes(params[:message_template])
      flash[:message] = flash_message(:type => "object_updated_successfully", :object => "message template")
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated Message Tempalte with ID #{@message_template.id}.")
    else
      flash[:error] = flash_message(:message => "A Template Already Exists With That Name")
    end
    respond_to do |format|
      format.js
    end
  end

  def send_email

    @list_headers = @current_user.all_lists
    @message_templates = MessageTemplate.find(:all)
    @message_template = MessageTemplate.new

    subject = params[:email][:subject]
    message_template = MessageTemplate.find(params[:message_template_id])
    list_header = ListHeader.find(params[:list_header_id])

    flash[:message] = flash_message(:message => "Your Email Has Been Scheduled For Dispatch And Will Be Sent Soon")
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) send an email with subject #{subject} to list header id #{list_header.id}.")

    for person in list_header.people_on_list do

      message = message_template.body
      message = message.gsub(/first_name/, "#{person.first_name}")
      message = message.gsub(/family_name/, "#{person.family_name}")

      email = BulkEmail.new(:subject => subject, :from => "feedback@memberzone.com.au", :to => person.primary_email.value, :body => message) unless person.primary_email.nil?
      email.save unless person.primary_email.nil?
      puts "Scheduled email #{email.to_yaml}" unless person.primary_email.nil?

    end

    respond_to do |format|
      format.js
    end

  end


  def search_email
    start_date = ((!params[:start_date].nil? && !params[:start_date].empty?) ? params[:start_date].to_date.strftime('%Y-%m-%d') : '0001-01-01 00:00:01')
    end_date = ((!params[:end_date].nil? && !params[:end_date].empty?) ? params[:end_date].to_date.strftime('%Y-%m-%d') : '9999-12-31 23:59:59')
    tbr = params[:email][:to_be_removed].to_i == 0 ? false : true
    dd = params[:email][:dispatch_date].to_i == 0 ? false : true
    status = params[:email][:status].to_i == 0 ? false : true

    query_string = dd ? "dispatch_date IS NOT NULL " : "dispatch_date IS NULL "

    @emails = BulkEmail.find(:all, :conditions => ["#{query_string} AND created_at >= ? AND created_at <= ? AND to_be_removed = ? AND status = ?", start_date, end_date, tbr, status])


    puts "*** Emails #{@emails.to_yaml}"

    EmailSearchGrid.find_all_by_login_account_id(session[:user]).each do |i|
      i.destroy
    end

    @emails.each do |email|
      @esg = EmailSearchGrid.new
      @esg.login_account_id = session[:user]
      @esg.grid_object_id = email.id
      @esg.field_1 = email.to
      @esg.field_2 = email.subject
      @esg.field_3 = email.created_at.strftime('%a %d %b %Y %H:%M:%S')
      @esg.field_4 = (email.dispatch_date.nil? ? "Not Dispatched" : "#{email.dispatch_date.strftime('%a %d %b %Y %H:%M:%S')}")
      @esg.field_5 = (email.to_be_removed.nil? ? "True" : "False")
      @esg.field_6 = (email.status? ? "Active" : "Inactive")
      @esg.save
    end

    respond_to do |format|
      format.js
    end


  end


end
