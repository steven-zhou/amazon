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
    @membership.person.is_member = true

    @membership.stage = "InitiateStage"
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

    unless @membership.update_attributes(params[:membership])
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

  def step_2
    @membership = Membership.find(params[:id])
    @person = Person.find(@membership.person_id) rescue @person = Person.new
    respond_to do |format|
      format.html
    end
  end

  def step_3
    respond_to do |format|
      format.html
    end
  end

  def step_1
    @person =  Person.find(params[:id]) unless params[:id].nil?
    @membership = Membership.new
    respond_to do |format|
      format.html
    end
  end
end
