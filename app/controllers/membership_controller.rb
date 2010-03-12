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

    unless @membership.person.nil?
      @membership.person.is_member = true
      @person= @membership.person
    else
      @person = Person.find(params[:id])
      @person.is_member = true
      @person.save
    end
    @email = @membership.person.primary_email rescue @person.primary_email
    @membership.stage = "InitiateStage"
    
    if @membership.save && @membership.person.save


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

            @body = PersonMailTemplate.find(params[:membership_log][:mail_template_id].to_i).body
            file_name="MembershipStartupMail"
            @entities = [@person]
            send_membership_mail(@body,file_name,@entities)
          
          end
          @membership_log.save
        end


        if  params[:membership_log][:email_sent]
          @membership_log.email_sent = true
          if params[:membership_log][:email_template_id]

            email = EmailDispatcher.create_send_person_email_template(@email.value)
            EmailDispatcher.deliver(email)
          end
          @membership_log.save
        end


      end

      @person = nil
      flash.now[:message] ||= " Saved successfully"
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created Membership #{@membership.id}.")
    else
      flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "person_id") if (!@membership.errors.on(:person_id).nil? && @membership.errors.on(:person_id).include?("has already been taken"))
      flash.now[:error] = flash_message(:type => "field_missing", :field => "person_id") if (!@membership.errors.on(:person_id).nil? &&  @membership.errors.on(:person_id).include?("can't be blank"))
      flash.now[:error] = flash_message(:type => "field_missing", :field => "membership_sub_status_id") if (!@membership.errors.on(:membership_sub_status_id).nil? &&  @membership.errors.on(:membership_sub_status_id).include?("can't be blank"))
      flash.now[:error] = flash_message(:type => "field_missing", :field => "membership_type_id") if (!@membership.errors.on(:membership_type_id).nil? &&  @membership.errors.on(:membership_type_id).include?("can't be blank"))
      #      flash.now[:error] = flash_message(:type => "field_missing", :field => "initiated_by") if (!@membership.errors.on(:initiated_by).nil? &&  @membership.errors.on(:initiated_by).include?("can't be blank"))
      #      flash.now[:error] = flash_message(:type => "field_missing", :field => "initiated_date") if (!@membership.errors.on(:initiated_date).nil? &&  @membership.errors.on(:initiated_date).include?("can't be blank"))
      #      flash.now[:error] = flash_message(:type => "field_missing", :field => "initiated_comment") if (!@membership.errors.on(:initiated_comment).nil? &&  @membership.errors.on(:initiated_comment).include?("can't be blank"))
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


    





    if @membership.update_attributes(params[:membership])
      flash.now[:message] = "Membership Update Successfully"

      #save to membership log

      if params[:membership][:membership_sub_status_id].to_i== MembershipSubStatus.find_by_name("Prospective").id

        params[:membership_log][:mail_template_id]=PersonMailTemplate.initiate_template_id
        params[:membership_log][:email_template_id]=PersonEmailTemplate.initiate_template_id
        params[:membership_log][:post_status] = "Prospective"

      elsif params[:membership][:membership_sub_status_id].to_i== MembershipSubStatus.find_by_name("In-review").id

        params[:membership_log][:mail_template_id]=PersonMailTemplate.inreview_template_id
        params[:membership_log][:email_template_id]=PersonEmailTemplate.inreview_template_id
        params[:membership_log][:post_status] = "In-review"

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
          puts "xxxxxxxxxxxxxxxxx"
          @membership_log.mail_sent = true
          if params[:membership_log][:mail_template_id]

            @body = PersonMailTemplate.find(params[:membership_log][:mail_template_id].to_i).body
            puts @body
            file_name="MembershipReviewMail"
            @entities = [@person]
            send_membership_mail(@body,file_name,@entities)

          end
          @membership_log.save
        end

        if  params[:membership_log][:email_sent]
          @membership_log.email_sent = true
          if params[:membership_log][:email_template_id]

            email = EmailDispatcher.create_send_person_email_template(@email.value)
            EmailDispatcher.deliver(email)
          end
          @membership_log.save
        end

      end

      #
      #      if params[:membership][:review_letter_sent]
      #        @membership.review_letter_sent = true
      #
      #        #config temp folder
      #        file_prefix = "public"
      #        file_dir = "temp/#{@current_user.user_name}/membership"
      #        FileUtils.mkdir_p("#{file_prefix}/#{file_dir}")
      #
      #
      #
      #        @membership_review_sheet = render_to_string(:partial => "membership/membership_review_sheet")
      #        File.open("#{file_prefix}/#{file_dir}/MembershipReviewSheet.html", 'w') do |f|
      #          f.puts "#{@membership_review_sheet}"
      #        end
      #        system "wkhtmltopdf #{file_prefix}/#{file_dir}/MembershipReviewSheet.html #{file_prefix}/#{file_dir}/MembershipReviewSheet.pdf ; rm #{file_prefix}/#{file_dir}/MembershipReviewSheet.html"
      #        flash.now[:comfirmation] = "<p>MembershipReviewSheet <a href=\'/#{file_dir}/MembershipReviewSheet.pdf\' target='_blank'>MembershipReviewSheet.pdf</a></p>"
      #      end


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
    @status = @membership.membership_sub_status.try(:name)
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

  def step_4
    @membership = Membership.find(params[:id]) rescue @membership = Membership.new
    @person = Person.find(@membership.person_id) rescue @person = Person.new
    @status = @membership.membership_status.try(:name)
    respond_to do |format|
      format.html
    end
  end

  def step_5
    @membership = Membership.find(params[:id]) rescue @membership = Membership.new
    @person = Person.find(@membership.person_id) rescue @person = Person.new
    @status = @membership.membership_status.try(:name)
    respond_to do |format|
      format.html
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
    flash.now[:comfirmation] = "<p>#{file_name} <a href=\'/#{file_dir}/#{file_name}.pdf\' target='_blank'>#{file_name}.pdf</a></p>"

  end
end
