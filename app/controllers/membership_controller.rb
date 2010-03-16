class MembershipController < ApplicationController
  # System Log stuff added

  def new
    @membership = Membership.new
    @default_stage_id = AmazonSetting.find_by_name("Initiated").try(:id)
    respond_to do |format|
      format.html
    end
  end


  def create
    @membership = Membership.new(params[:membership])

    unless @membership.person.nil?  #from Membership Applcation page
      @membership.person.is_member = true
      @person= @membership.person
    else                            #from person profile
      @person = Person.find(params[:id])
      @person.is_member = true
      #      @person.save
    end
    #    @email = @membership.person.primary_email rescue @person.primary_email  get the person email to send email
    @email =  @person.primary_email  #get the person email to send email
    @membership.stage = "InitiateStage"
    if params[:membership][:active]
      @membership.active = true
    else
      @membership.active = false
    end
    
    if @membership.save && @person.save


      #save to membership log

      @membership_log = MembershipLog.new(params[:membership_log])
      @membership_log.person_id = @membership.person.id
      @membership_log.membership_id = @membership.id
      if params[:membership_log][:send_mail]
        @membership_log.send_mail = true
      end
      if params[:membership_log][:send_email]
        @membership_log.send_email = true
      end


      if @membership_log.save


        if params[:membership_log][:mail_sent]
          @membership_log.mail_sent = true
          if params[:membership_log][:mail_template_id]
            @mail_body = PersonMailTemplate.find(params[:membership_log][:mail_template_id].to_i).body
            file_name="MembershipStartupMail"
            @entities = [@person]
            send_membership_mail(@mail_body,file_name,@entities)
          
          end
          @membership_log.save
        end


        if  params[:membership_log][:email_sent]
          @membership_log.email_sent = true
          if params[:membership_log][:email_template_id]
            email_body = PersonEmailTemplate.find(params[:membership_log][:email_template_id]).body
            send_membership_email(@email.try(:value),email_body)

          end
          @membership_log.save
        end


      end

      

      flash.now[:message] ||= " Saved successfully"
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created Membership #{@membership.id}.")
      if params[:auto_approve]
        @auto_approve = true
        @membership_id = @membership.id
        @membership_logs = @membership.membership_logs
      else
        @membership = Membership.new
        @person = nil #set the person to be nil to clear the from after create
      end
    else
      flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "person_id") if (!@membership.errors.on(:person_id).nil? && @membership.errors.on(:person_id).include?("has already been taken"))
      flash.now[:error] = flash_message(:type => "field_missing", :field => "person_id") if (!@membership.errors.on(:person_id).nil? &&  @membership.errors.on(:person_id).include?("can't be blank"))
      flash.now[:error] = flash_message(:type => "field_missing", :field => "membership_sub_status_id") if (!@membership.errors.on(:membership_sub_status_id).nil? &&  @membership.errors.on(:membership_sub_status_id).include?("can't be blank"))
      flash.now[:error] = flash_message(:type => "field_missing", :field => "membership_type_id") if (!@membership.errors.on(:membership_type_id).nil? &&  @membership.errors.on(:membership_type_id).include?("can't be blank"))
      flash.now[:error] = "Please make sure the initiated date is entered in valid format (dd-mm-yyyy)" if (!@membership.errors.on(:initiated_date).nil? &&  @membership.errors.on(:initiated_date).include?("is_invalid"))
    end
    
    respond_to do |format|
      format.js
    end
  end

  def edit
    @membership = Membership.find(params[:id])
    @person = Person.find(@membership.person_id)
    @type = params[:params2]
    @membership_logs = @membership.membership_logs
    respond_to do |format|
      format.js
    end
  end


  def update
    @membership = Membership.find(params[:id])
    @person = @membership.person
    @field= params[:field]
    @email = @membership.person.primary_email
    case @field
    
    when "review_page" then @membership.stage="ReviewStage"
    when "finalize_page" then @membership.stage="FinalizeStage"
    end
    @render_page = params[:render_page]


    type = []
    type <<  MembershipStatus.find_by_name("Prospective").id
    type << MembershipStatus.find_by_name("In-review").id
    @type = type.join(',')


    if @membership.update_attributes(params[:membership])
      flash.now[:message] = "Membership Update Successfully"

      #save to membership log

      if params[:membership][:membership_status_id].to_i== MembershipStatus.find_by_name("Prospective").id

        params[:membership_log][:mail_template_id]=PersonMailTemplate.initiate_template_id
        params[:membership_log][:email_template_id]=PersonEmailTemplate.initiate_template_id
        params[:membership_log][:post_status] = "Prospective"

      elsif params[:membership][:membership_status_id].to_i== MembershipStatus.find_by_name("In-review").id

        params[:membership_log][:mail_template_id]=PersonMailTemplate.inreview_template_id
        params[:membership_log][:email_template_id]=PersonEmailTemplate.inreview_template_id
        params[:membership_log][:post_status] = "In-review"

      elsif params[:membership][:membership_status_id].to_i== MembershipStatus.approve.id
        params[:membership_log][:mail_template_id]=PersonMailTemplate.approve_template_id
        params[:membership_log][:email_template_id]=PersonEmailTemplate.approve_template_id
        params[:membership_log][:post_status] = "Actived"


      elsif params[:membership][:membership_status_id].to_i== MembershipStatus.find_by_name("Rejected").id

        params[:membership_log][:mail_template_id]=PersonMailTemplate.reject_template_id
        params[:membership_log][:email_template_id]=PersonEmailTemplate.reject_template_id
        params[:membership_log][:post_status] = "Rejected"
      end

      @membership_log = MembershipLog.new(params[:membership_log])
      @membership_log.person_id = @membership.person.id
      @membership_log.membership_id = @membership.id
      if params[:membership_log][:send_mail]
        @membership_log.send_mail = true
      end
      if params[:membership_log][:send_email]
        @membership_log.send_email = true
      end




      if @membership_log.save

        if params[:membership_log][:mail_sent]

          @membership_log.mail_sent = true
          if params[:membership_log][:mail_template_id]

            mail_body = PersonMailTemplate.find(params[:membership_log][:mail_template_id].to_i).body

            file_name="MembershipReviewMail"
            @entities = [@person]
            send_membership_mail(mail_body,file_name,@entities)

          end
          @membership_log.save
        end

        if  params[:membership_log][:email_sent]
          @membership_log.email_sent = true
          if params[:membership_log][:email_template_id]
            email_body = PersonEmailTemplate.find(params[:membership_log][:email_template_id]).body
            send_membership_email(@email.value,email_body)

          end
          @membership_log.save
        end

      end


      if params[:membership][:approve_letter_sent]
        @membership.approve_letter_sent = true

        

        #config temp folder
        file_prefix = "public"
        file_dir = "temp/#{@current_user.user_name}/membership"
        FileUtils.mkdir_p("#{file_prefix}/#{file_dir}")



        @membership_approve_sheet = render_to_string(:partial => "membership/membership_approve_sheet")
        File.open("#{file_prefix}/#{file_dir}/MembershipApproveSheet.html", 'w') do |f|
          f.puts "#{@membership_approve_sheet}"
        end
        system "wkhtmltopdf #{file_prefix}/#{file_dir}/MembershipApproveSheet.html #{file_prefix}/#{file_dir}/MembershipApproveSheet.pdf ; rm #{file_prefix}/#{file_dir}/MembershipApproveSheet.html"
        flash.now[:comfirmation] = "<p>MembershipApproveSheet <a href=\'/#{file_dir}/MembershipApproveSheet.pdf\' target='_blank'>MembershipApproveSheet.pdf</a></p>"
      end




    else
      flash.now[:error] = "error"
    end

    @person = Person.new
    respond_to do |format|
      format.js
    end
  end


  def review

    respond_to do |format|
      format.html
    end

  end

  def membership_person_lookup
    @membership = Membership.new
    @person = Person.find(params[:id]) rescue @person=nil
    respond_to do |format|
      format.js
    end
  end
  
  def membership_intiator_lookup

    @person = Person.find(params[:id]) rescue @person=nil
    @update_field = params[:update_field]
    respond_to do |format|
      format.js
    end
  end

  def page_initial
    @render_page = params[:render_page]
    @field = params[:field]
    @membership = Membership.new
    respond_to do |format|
      format.js
    end
  end

  def step_1
    @person =  Person.find(params[:id]) unless params[:id].nil?
    @membership = Membership.new
    respond_to do |format|
      format.html
    end
  end

  def step_2
    @membership = Membership.find(params[:id]) rescue @membership = Membership.new
    @membership_logs = @membership.membership_logs
    @person = Person.find(@membership.person_id) rescue @person = Person.new
    @status = @membership.membership_status.try(:name)


    status = ["Prospective","In-review"]
    @membership_status = MembershipStatus.find(:all, :conditions => ["Name IN (?)",status ])

    type = []
    type <<  MembershipStatus.find_by_name("Prospective").id
    type << MembershipStatus.find_by_name("In-review").id
    @type = type.join(',')
    respond_to do |format|
      format.html
    end
  end

  def step_3
    @membership = Membership.find(params[:id]) rescue @membership = Membership.new
    @membership_logs = @membership.membership_logs
    @person = Person.find(@membership.person_id) rescue @person = Person.new
    @status = @membership.membership_sub_status.try(:name)
    respond_to do |format|
      format.html
    end
  end

  def life
    status = ["Actived"]
    @membership_status = MembershipStatus.find(:all, :conditions => ["Name IN (?)",status ])
    @type=[MembershipStatus.find_by_name("Actived").id]
    respond_to do |format|
      format.html
    end
  end

  def step_5
    @membership = Membership.find(params[:id]) rescue @membership = Membership.new
    @membership_logs = @membership.membership_logs
    @person = Person.find(@membership.person_id) rescue @person = Person.new
    @status = @membership.membership_sub_status.try(:name)
    respond_to do |format|
      format.html
    end
  end



  def show_membership_fee
    @membership_id = Membership.find(params[:id]).id

    respond_to do |format|
      format.js
    end

    
  end




  def send_membership_mail(body,file_name,entities)
    #config temp folder
    @body = body
    @entities = entities
    file_prefix = "public"
    file_dir = "temp/#{@current_user.user_name}/membership"
    FileUtils.mkdir_p("#{file_prefix}/#{file_dir}")
    @membership_mail = render_to_string(:partial => "membership/membership_mail")
    File.open("#{file_prefix}/#{file_dir}/#{file_name}.html", 'w') do |f|
      f.puts "#{@membership_mail}"
    end
    system "wkhtmltopdf #{file_prefix}/#{file_dir}/#{file_name}.html #{file_prefix}/#{file_dir}/#{file_name}.pdf ; rm #{file_prefix}/#{file_dir}/#{file_name}.html"
    flash.now[:confirmation] = "<p>#{file_name} <a href=\'/#{file_dir}/#{file_name}.pdf\' target='_blank'>#{file_name}.pdf</a></p>"

  end


  def send_membership_email(email_address,content)
    email = EmailDispatcher.create_send_person_email_template(email_address,content)
    EmailDispatcher.deliver(email)
  end

  def auto_approve
    @membership_id = Membership.find(params[:id]).id

    respond_to do |format|
      format.js
    end
  end

  def end_cycle
    status = ["Rejected","Terminated","Removed","Archived"]
   @membership_status = MembershipStatus.find(:all, :conditions => ["Name IN (?)",status ])
  
    respond_to do |format|
      format.html
    end
  end

  def membership_filter
    conditions = Array.new  
    creator_username = params[:creator_username]

    #----------------check creator--------------------------------------------------------
    unless (creator_username.blank?)
      creator_id = LoginAccount.find_by_user_name(creator_username).id.to_s rescue creator_id = "0"
      conditions << ("creator_id="+creator_id)
    end


    membership_status = params[:membership_status]
    
    unless (membership_status=="")
#      membership_status_id = MembershipStatus.find_by_name(membership_status).id
      conditions << ("membership_status_id="+membership_status.to_s)
    end

    #----------------check date--------------------------------------------------------

    if valid_date(params[:start_date]) && valid_date(params[:end_date])
      start_date = params[:start_date].to_date.yesterday.to_s
      end_date = params[:end_date].to_date.tomorrow.to_s
      unless start_date.blank? || end_date.blank?
        start_date = "#{Date.today().last_year.yesterday.to_s}" if start_date.blank?
        end_date = "#{Date.today().tomorrow.to_s}" if end_date.blank?
        conditions << ("start_date=" + start_date)
        conditions << ("end_date=" + end_date)
      end
      @date_valid = true
    else
      @date_valid = false
      flash.now[:error] = "Please make sure the start date and end date are entered in valid format (dd-mm-yyyy)"
    end

    #----------------join all conditions--------------------------------------------------------
    @query_conditions = conditions.join('&')
    @state = params[:state]

    if (params[:state] == "end_cycle")

      @type = []
      @type <<  MembershipStatus.find_by_name("Rejected").id
      @type << MembershipStatus.find_by_name("Terminated").id
      @type << MembershipStatus.find_by_name("Removed").id
      @type << MembershipStatus.find_by_name("Archived").id
      @type = @type.join(',')
    elsif (params[:state]=="life")
      @type = [MembershipStatus.find_by_name("Actived").id]
    elsif (params[:state]=="review")
      @type = []
      @type <<  MembershipStatus.find_by_name("Prospective").id
      @type << MembershipStatus.find_by_name("In-review").id
      @type = @type.join(',')
    end


    respond_to do |format|
      format.js
    end
  end
end
