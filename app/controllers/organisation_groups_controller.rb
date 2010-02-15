class OrganisationGroupsController < ApplicationController
  # System logging added

  def show
    @organisation_group = OrganisationGroup.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def create
    @organisation = Organisation.find(params[:organisation_id].to_i)
    @group = Tag.find(params[:organisation_group_id].to_i) rescue @group = Tag.new
    @organisation_group = OrganisationGroup.new
    @organisation_group.organisation_id= @organisation.id
    @organisation_group.tag_id = @group.id
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created OrganisationGroup #{@organisation_group.id}.")
   if @organisation_group.save
   else
       flash.now[:error]= "Please Enter All Required Data"if(!@organisation_group.errors[:tag_id].nil? && @organisation_group.errors.on(:tag_id).include?("can't be blank"))
      flash.now[:error]= flash_message(:type => "uniqueness_error", :field => "Group")if(!@organisation_group.errors[:tag_id].nil? && @organisation_group.errors.on(:tag_id).include?("has already been taken"))
   end
    respond_to do |format|
      format.js
    end     
  end


  def edit
    @organisation_group = OrganisationGroup.find(params[:id])
    @organisation_group_type = @organisation_group.group_type
    @organisation_group_meta_type= @organisation_group_type.tag_type
    @organisation_group_meta_meta_type =  @organisation_group_meta_type.tag_meta_type
    respond_to do |format|
      format.js
    end
  end

  def update
    @organisation_group= OrganisationGroup.find(params[:id])   
    if @organisation_group.update_attributes(params[:organisation_group])
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) edited Organisation Group #{@organisation_group.id}.")
    else
      flash.now[:error]= flash_message(:type => "field_missing", :field => "Group Type")if(!@organisation_group.errors[:tag_id].nil? && @organisation_group.errors.on(:tag_id).include?("can't be blank"))
      flash.now[:error]= flash_message(:type => "uniqueness_error", :field => "Group")if(!@organisation_group.errors[:tag_id].nil? && @organisation_group.errors.on(:tag_id).include?("has already been taken"))
    end
      render 'show.js' 
         
  end


  def destroy
    @organisation_group = OrganisationGroup.find(params[:id].to_i)
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted Orgnanisation Group #{@organisation_group.id}.")
    @organisation_group.destroy
    respond_to do |format|
      format.js
    end
  end


  def show_group_members
    @organisation_group = OrganisationGroup.find(params[:organisation_group_id].to_i)
    @group_members = OrganisationGroup.find(:all, :conditions => ["tag_id = ?", @organisation_group.tag_id])
    @group_members.delete_if{|x| x.organisation_id == @organisation_group.organisation_id }

    ShowOtherGroupOrganisationsGrid.find_all_by_login_account_id(session[:user]).each do |i|
      i.destroy
    end

    @group_members.each do |i|
      @sogog = ShowOtherGroupOrganisationsGrid.new
      @sogog.login_account_id = session[:user]
      @sogog.grid_object_id = i.group_owner.id
      @sogog.field_1 = i.group_owner.full_name
      @sogog.field_2 = i.group_owner.registered_name
      @sogog.field_3 = i.group_owner.trading_as
      @sogog.save
    end
    respond_to do |format|
      format.js
    end
  end

  def page_initial
    @render_page = params[:render_page]
    @field = params[:field]
    @organisation_group = OrganisationGroup.new
    @organisation = Organisation.find_by_id(params[:params1])

    respond_to do |format|
      format.js
    end
  end

end
