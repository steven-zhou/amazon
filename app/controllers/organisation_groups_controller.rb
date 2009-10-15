class OrganisationGroupsController < ApplicationController

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
    @organisation_group.save
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
      render 'show.js' 
    end     
  end


  def destroy
    @organisation_group = OrganisationGroup.find(params[:id].to_i)
    @organisation_group.destroy
    respond_to do |format|
      format.js
    end
  end


  def show_group_members
    @organisation_group = OrganisationGroup.find(params[:organisation_group_id].to_i)
    @group_members = OrganisationGroup.find(:all, :conditions => ["tag_id = ?", @organisation_group.tag_id])
    @group_members.delete_if{|x| x.organisation_id == @organisation_group.organisation_id }

    @group_members.each do |i|
      @sogog = ShowOtherGroupOrganisationsGrid.new
      @sogog.login_account_id = session[:user]
      @sogog.grid_object_id = i.group_owner.id
      @sogog.field_1 = i.group_owner.trading_as
      @sogog.field_2 = i.group_owner.registered_name
      @sogog.save
    end
    respond_to do |format|
      format.js
    end
  end

end
