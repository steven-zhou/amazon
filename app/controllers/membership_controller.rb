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
    else
      @person = Person.find(params[:id])
      @person.is_member = true
      @person.save
    end
     @email = @membership.person.primary_email rescue @person.primary_email
    @membership.stage = "InitiateStage"

    if params[:membership][:initiate_mail_id]
      @membership.initiate_mail_id = PersonMailTemplate.initiate_template_id
    end
    if params[:membership][:initiate_email_id]
      @membership.initiate_email_id = PersonEmailTemplate.initiate_template_id
    end

    if params[:membership][:initiate_letter_sent]
      @membership.initiate_letter_sent = true
    if params[:membership][:initiate_mail_id]
      #config temp folder
      file_prefix = "public"
      file_dir = "temp/#{@current_user.user_name}/membership"
      FileUtils.mkdir_p("#{file_prefix}/#{file_dir}")



      @membership_initiate_sheet = render_to_string(:partial => "membership/membership_initiate_sheet")
      File.open("#{file_prefix}/#{file_dir}/MembershipInitateSheet.html", 'w') do |f|
        f.puts "#{@membership_initiate_sheet}"
      end
      system "wkhtmltopdf #{file_prefix}/#{file_dir}/MembershipInitateSheet.html #{file_prefix}/#{file_dir}/MembershipInitateSheet.pdf ; rm #{file_prefix}/#{file_dir}/MembershipInitateSheet.html"
      flash.now[:comfirmation] = "<p>MembershipInitateSheet <a href=\'/#{file_dir}/MembershipInitateSheet.pdf\' target='_blank'>MembershipInitateSheet.pdf</a></p>"
    end
         if params[:membership][:initiate_email_id]

       email = EmailDispatcher.create_send_person_email_template(@email.value)
       EmailDispatcher.deliver(email)
    end

    end



    
    if @membership.save && @membership.person.save

      flash.now[:message] ||= " Saved successfully"
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created Membership #{@membership.id}.")
    else
      flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "person_id") if (!@membership.errors.on(:person_id).nil? && @membership.errors.on(:person_id).include?("has already been taken"))
      flash.now[:error] = flash_message(:type => "field_missing", :field => "person_id") if (!@membership.errors.on(:person_id).nil? &&  @membership.errors.on(:person_id).include?("can't be blank"))
      flash.now[:error] = flash_message(:type => "field_missing", :field => "membership_status_id") if (!@membership.errors.on(:membership_status_id).nil? &&  @membership.errors.on(:membership_status_id).include?("can't be blank"))
      flash.now[:error] = flash_message(:type => "field_missing", :field => "membership_type_id") if (!@membership.errors.on(:membership_type_id).nil? &&  @membership.errors.on(:membership_type_id).include?("can't be blank"))
      flash.now[:error] = flash_message(:type => "field_missing", :field => "initiated_by") if (!@membership.errors.on(:initiated_by).nil? &&  @membership.errors.on(:initiated_by).include?("can't be blank"))
      flash.now[:error] = flash_message(:type => "field_missing", :field => "initiated_date") if (!@membership.errors.on(:initiated_date).nil? &&  @membership.errors.on(:initiated_date).include?("can't be blank"))
      flash.now[:error] = flash_message(:type => "field_missing", :field => "initiated_comment") if (!@membership.errors.on(:initiated_comment).nil? &&  @membership.errors.on(:initiated_comment).include?("can't be blank"))
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

    @default_stage_id = case @type
    when "Initiated" then AmazonSetting.find_by_name("Reviewed").try(:id)
    when "Reviewed" then AmazonSetting.find_by_name("Approved").try(:id)
    when "Approved" then AmazonSetting.find_by_name("Suspended").try(:id)
    when "Suspended" then AmazonSetting.find_by_name("Terminated").try(:id)
    end

    respond_to do |format|
      format.js
    end
  end


  def update
    @membership = Membership.find(params[:id])
    
    @field= params[:field]
    case @field
    
    when "review_page" then @membership.stage="ReviewStage"
    when "finalize_page" then @membership.stage="FinalizeStage"
    end
    @render_page = params[:render_page]

    if @membership.update_attributes(params[:membership])
      flash.now[:message] = "Membership Update Successfully"


      if params[:membership][:review_letter_sent]
        @membership.review_letter_sent = true

        #config temp folder
        file_prefix = "public"
        file_dir = "temp/#{@current_user.user_name}/membership"
        FileUtils.mkdir_p("#{file_prefix}/#{file_dir}")



        @membership_review_sheet = render_to_string(:partial => "membership/membership_review_sheet")
        File.open("#{file_prefix}/#{file_dir}/MembershipReviewSheet.html", 'w') do |f|
          f.puts "#{@membership_review_sheet}"
        end
        system "wkhtmltopdf #{file_prefix}/#{file_dir}/MembershipReviewSheet.html #{file_prefix}/#{file_dir}/MembershipReviewSheet.pdf ; rm #{file_prefix}/#{file_dir}/MembershipReviewSheet.html"
        flash.now[:comfirmation] = "<p>MembershipReviewSheet <a href=\'/#{file_dir}/MembershipReviewSheet.pdf\' target='_blank'>MembershipReviewSheet.pdf</a></p>"
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
    @default_stage_id = AmazonSetting.find_by_name("Initiated").try(:id)
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
    @default_stage_id = AmazonSetting.find_by_name("Initiated").try(:id)
    @membership = Membership.new
    respond_to do |format|
      format.html
    end
  end

  def step_2
    @membership = Membership.find(params[:id]) rescue @membership = Membership.new
    @person = Person.find(@membership.person_id) rescue @person = Person.new
    @status = @membership.membership_status.try(:name)
    @default_stage_id = AmazonSetting.find_by_name("Reviewed").try(:id)
    respond_to do |format|
      format.html
    end
  end

  def step_3
    @membership = Membership.find(params[:id]) rescue @membership = Membership.new
    @person = Person.find(@membership.person_id) rescue @person = Person.new
    @status = @membership.membership_status.try(:name)
    @default_stage_id = AmazonSetting.find_by_name("Approved").try(:id)
    respond_to do |format|
      format.html
    end
  end

  def step_4
    @membership = Membership.find(params[:id]) rescue @membership = Membership.new
    @person = Person.find(@membership.person_id) rescue @person = Person.new
    @status = @membership.membership_status.try(:name)
    @default_stage_id = AmazonSetting.find_by_name("Suspended").try(:id)
    respond_to do |format|
      format.html
    end
  end

  def step_5
    @membership = Membership.find(params[:id]) rescue @membership = Membership.new
    @person = Person.find(@membership.person_id) rescue @person = Person.new
    @status = @membership.membership_status.try(:name)
    @default_stage_id = AmazonSetting.find_by_name("Terminated").try(:id)
    respond_to do |format|
      format.html
    end
  end
end
