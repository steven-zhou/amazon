class OrganisationRelationshipsController < ApplicationController

  def new
    @organisation_relationship = OrganisationRelationship.new
    @organisation = Organisation.find(params[:param1])
    respond_to do |format|
      format.js
    end
  end
  
  def create
    
    OrganisationRelationship.delete_all_relationship(params[:organisation_relationship][:related_organisation_id].to_i)
    @relationship = OrganisationRelationship.new(params[:organisation_relationship])

    if @relationship.save #call back will update the level of branch
      @organisation = Organisation.find(params[:organisation_relationship][:source_organisation_id].to_i)
      @level = @organisation.level
      @next_level = (@level.to_i)+1
      @target = params[:target]
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created Organisation Relationship #{@relationship.id}.")
      flash.now[:message]= "saved successfully"      
    else
      flash.now[:error] = "Please Enter All Required Data"if (!@relationship.errors[:related_organisation_id].nil? && @relationship.errors.on(:related_organisation_id).include?("can't be blank"))
      flash.now[:error] = "Invalid Organisation ID" if (!@relationship.errors[:related_organisation_id].nil? && @relationship.errors.on(:related_organisation_id).include?("can't be invalid"))
      flash.now[:error] = "Can't Be Same As Parent Organisation" if (!@relationship.errors[:related_organisation_id].nil? && @relationship.errors.on(:related_organisation_id).include?("can't be same as source organisation"))
      flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "Related Organisation")if (!@relationship.errors[:related_organisation_id].nil? && @relationship.errors.on(:related_organisation_id).include?("has already been taken"))
    end
    respond_to do |format|
      format.js
    end
  end

  def lookup
    @organisation = Organisation.find(params[:id])
    if !@organisation.organisation_as_source.blank? || !@organisation.organisation_as_related.blank?
      flash.now[:error] = "All Relationships Of This Organisation Will Be Delete."
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy

    #    @source_organisation = Organisation.find(params[:id].to_i)
    #    @organisation = Organisation.find(params[:id].to_i)
    #    if !params[:related_organisation_id].blank?
    #      @organisation_relationship = OrganisationRelationship.find(params[:related_organisation_id].to_i)
    #      @relationship = OrganisationRelationship.find_by_source_organisation_id(@source_organisation.id)
    #    end
    #
    #    if !params[:source_organisation_id].blank?
    #      @organisation_relationship = OrganisationRelationship.find(params[:source_organisation_id].to_i)
    #      @relationship = OrganisationRelationship.find_by_related_organisation_id(@source_organisation.id)
    #    end
    #    @organisation_relationship.destroy
    @related_organisation = OrganisationRelationship.find_by_related_organisation_id(params[:id])
    @organisation = Organisation.find(@related_organisation.source_organisation_id)
    @level = @organisation.level
    @next_level = (@level.to_i)+1
    @target = params[:target]
    OrganisationRelationship.delete_all_relationship(params[:id].to_i)
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted Relationship ")

    #    @relationship_new = Relationship.new

    respond_to do |format|
      format.js
    end
  end

  def page_initial
    @render_page = params[:render_page]
    @field = params[:field]
    @relationship = OrganisationRelationship.new
    @organisation = Organisation.find_by_id(params[:params1])

    respond_to do |format|
      format.js
    end
  end

  def show_branches
    @organisation = Organisation.find(params[:grid_object_id])
    @level = params[:params2]
    @next_level = (@level.to_i)+1
    @next_level_label = "Level #{@next_level} -" + ClientSetup.send("label_#{@next_level}")
    @target = params[:target]
    respond_to do |format|
      format.js
    end
  end
  
end
