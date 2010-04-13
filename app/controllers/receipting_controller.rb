class ReceiptingController < ApplicationController  

  def personal_deposit
    if PrimaryList.first.entity_on_list.empty?
      redirect_to :controller =>"module",:action=>"core"
    else
      session[:module] = "receipting"
      @group_types = @current_user.group_types
      @list_headers = @current_user.all_person_lists
      @org_list_headers = @current_user.all_organisation_lists
      @list_header = ListHeader.find(session[:current_list_id]) rescue @list_header = @list_headers.first

      @org_list_header = ListHeader.find(session[:current_org_list_id]) rescue @org_list_header = @org_list_headers.first

      @p = @list_header.entity_on_list.uniq
      @person = Person.find(session[:current_person_id]) rescue @person = @p[0]
      session[:entity_type] = "Person"
      session[:entity_id] = @person.id
      session[:current_list_id] = @list_header.id
      session[:current_org_list_id] = @org_list_header.id
      session[:current_person_id] = @person.id
      respond_to do |format|
        format.html
      end
    end


  end

  def organisational_deposit
    session[:module] = "receipting"
    @list_headers = @current_user.all_organisation_lists
    @list_header = ListHeader.find(session[:current_org_list_id]) rescue @list_header = @list_headers.first
    @o = @list_header.entity_on_list.uniq
    @organisation = Organisation.find(session[:current_organisation_id]) rescue @organisation = @o[0]
    session[:entity_type] = "Organisation"
    session[:entity_id] = @organisation.id
    session[:current_org_list_id] = @list_header.id
    session[:current_organisation_id] = @organisation.id
    respond_to do |format|
      format.html
    end
  end

  def show_personal_deposit
    @current_tab_id = params[:current_tab_id]
    if request.post?
      #find the list in top
      @list_header = ListHeader.find(params[:list_header_id])
      # params person_id not blank then pass it to params[:id]
      params[:id] = params[:person_id] unless (params[:person_id].nil? || params[:person_id].empty?)
      c1 = Array.new
      #find all people in the lis
      c1 = @list_header.entity_on_list.uniq
      @person = Person.find_by_id(params[:id].to_i)
      unless c1.include?(@person)
        #if list just have 1,2 you type 3, you will get person id is 1.---the first valid people in the list
        @person = c1.first
      else
        #if you type the right id of people which is valid in the list
        @person
      end
      session[:entity_id] = @person.id
      session[:entity_type] = "Person"
      session[:current_person_id] = @person.id
      session[:current_list_id] = @list_header.id

      @p = Array.new
      @p = @list_header.entity_on_list.uniq
      @list_headers = @current_user.all_person_lists
    else
      #request.get

      @list_headers = @current_user.all_person_lists
      @list_header = ListHeader.find(session[:current_list_id]) rescue @list_header = @list_headers.first
      @p = @list_header.entity_on_list.uniq

      @current_person = Person.find(session[:current_person_id]) rescue @current_person = @p[0]
      @person = case params[:target]
      when 'First' then @p[0]
      when 'Previous' then @p.at((@p.index(@current_person))-1)
      when 'Next' then @p.index(@current_person) != @p.index(@p.last) ? @p[@p.index(@current_person)+1] : @p.first
      when 'Last' then @p.fetch(-1)
      when "default" then params[:grid_object_id].nil? ? @current_person : Person.find(params[:grid_object_id])
      end
      session[:entity_id] = @person.id
      session[:entity_type] = "Person"
      session[:current_person_id] = @person.id
      session[:current_list_id] = @list_header.id
    end
    respond_to do |format|
      format.js
    end
  end

  def show_organisational_deposit

    @current_tab_id = params[:current_tab_id]


    if request.post?
      #find the list in top
      @list_header = ListHeader.find(params[:list_header_id])
      # params _id not blank then pass it to params[:id]
      params[:id] = params[:organisation_id] unless (params[:organisation_id].nil? || params[:organisation_id].empty?)
      c1 = Array.new
      #find all people in the lis
      c1 = @list_header.entity_on_list.uniq

      @organisation = Organisation.find(params[:id].to_i)
      unless c1.include?(@organisation)
        #if list just have 1,2 you type 3, you will get person id is 1.---the first valid people in the list
        @organisation = c1.first
      else
        #if you type the right id of people which is valid in the list
        @organisation
      end

      session[:entity_id] = @organisation.id
      session[:entity_type] = "Organisation"
      session[:current_organisation_id] = @organisation.id
      session[:current_org_list_id] = @list_header.id
      @o = Array.new
      @o = @list_header.entity_on_list.uniq
      @list_headers = @current_user.all_organisation_lists

    else
      #request.get

      @list_headers = @current_user.all_organisation_lists
      @list_header = ListHeader.find(session[:current_org_list_id]) rescue @list_header = @list_headers.first
      @o = @list_header.entity_on_list.uniq

      @current_organisation = Organisation.find(session[:current_organisation_id]) rescue @current_organisation = @o[0]
      @organisation = case params[:target]
      when 'First' then @o[0]
      when 'Previous' then @o.at((@o.index(@current_organisation))-1)
      when 'Next' then (@o.index(@current_organisation) == @o.index(@o.last)) ? @o.first : @o[@o.index(@current_organisation)+1]
      when 'Last' then @o.fetch(-1)
      when "default" then params[:grid_object_id].nil? ? @current_organisation : Organisation.find(params[:grid_object_id])
      end
      session[:entity_id] = @organisation.id
      session[:entity_type] = "Organisation"
      session[:current_organisation_id] = @organisation.id
      session[:current_org_list_id] = @list_header.id
    end



    respond_to do |format|
      format.js
    end
  end

  def enquiry
    @bank_accounts = ClientBankAccount.active_client_bank_account
    @payment_method_meta_types = PaymentMethodMetaType.manual
    @payment_method_types = PaymentMethodType.find(:all, :conditions => ["tag_type_id = ? AND status = true and to_be_removed = false", @payment_method_meta_types.first.id])
    @receipt_via =ReceivedVia.active_received_via
    @receipt_accounts=ReceiptAccount.active
    respond_to do |format|
      format.html
    end
  end

  def bank_run
    @bank_accounts = BankAccount.find(:all, :order => "id asc")
    respond_to do |format|
      format.html
    end
  end

  def page_initial
    @render_page = params[:render_page]
    @field = params[:field]
    @bank_accounts = BankAccount.find(:all, :order => "id asc")
    respond_to do |format|
      format.js
    end
  end

  def bank_run_document_filter
    #--------------- this function is for the bank run document---pdf file system
    conditions = Array.new
    bank_run_id = params[:bank_run_document_filter][:bank_run_id]
    deposit_bank_account_id = params[:bank_run_document_filter][:deposit_bank_account_id]
    document_name = params[:bank_run_document_filter][:document_type]
    document_type = params[:bank_run_document_filter][:document_type]+".pdf"
   
    @date_valid = true
    @user_name = @current_user.user_name
  


    # check the date is valid or not
    if valid_date(params[:bank_run_document_filter][:start_date]) && valid_date(params[:bank_run_document_filter][:end_date])
      start_date = params[:bank_run_document_filter][:start_date].to_date
      end_date = params[:bank_run_document_filter][:end_date].to_date
      pdf_directory = "public/temp/"+@user_name+"/bank_run_reports/"
      dir = Dir.new(pdf_directory) rescue dir = nil
      dir = dir.entries.delete_if {|x| !(x =~ /(pdf)$/)}

      @bank_run_documents = dir.nil? ? [] : (dir.entries - [".", ".."]).sort  #grab all the pdf document from the file system

      for m in @bank_run_documents do
        #---comment--all temp file will be delete
        @bank_run_documents = @bank_run_documents - [m] if (m.split('-')[0] == "temp")
         #---comment--all file[2] != document_type will be delete  now document_type == "xxx.pdf"

        @bank_run_documents = @bank_run_documents - [m] if (m.split('-')[2] != document_type) unless document_name.blank?
       
        #---comment--all file will be delete if the file date not in the range
        file_date = File.new(pdf_directory+m).mtime.to_date
        @bank_run_documents = @bank_run_documents - [m] if (file_date < start_date || file_date > end_date)

        # used for the bank_run_id is not blank
        unless bank_run_id.blank?
          @bank_run_documents = @bank_run_documents-[m] if (m.split('-')[0] != bank_run_id)
          
        end
        # used for the deposit_bank_account_id is not blank
        unless deposit_bank_account_id.blank?
          @bank_run_documents = @bank_run_documents-[m] if (m.split('-')[1] != deposit_bank_account_id)
        end
      end
    else
      @date_valid = false
      flash.now[:error] = "Please make sure the start date and end date are entered in valid format (dd-mm-yyyy)"
    end

        
    respond_to do |format|
      format.js
    end
    
  end


end