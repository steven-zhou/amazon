class OrganisationRelationshipsController < ApplicationController

  def new
    @organisation_relationship = OrganisationRelationship.new
    @organisation = Organisation.find(params[:param1])
    respond_to do |format|
      format.js
    end
  end
  
  def create
    
    #    OrganisationRelationship.delete_all_relationship(params[:organisation_relationship][:related_organisation_id].to_i)
    @relationship = OrganisationRelationship.new(params[:organisation_relationship])

    if @relationship.save #call back will update the level of branch
      @organisation = Organisation.find(params[:organisation_relationship][:source_organisation_id].to_i)
      @relate_organisaton = Organisation.find(params[:organisation_relationship][:related_organisation_id].to_i)
      @level = @organisation.level
      @next_level = (@level.to_i)+1
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created Organisation Relationship #{@relationship.id}.")
      flash.now[:message]= "saved successfully"      
    else
      flash.now[:error] = "Please Enter All Required Data"if (!@relationship.errors[:related_organisation_id].nil? && @relationship.errors.on(:related_organisation_id).include?("can't be blank"))
      flash.now[:error] = "Invalid Organisation ID" if (!@relationship.errors[:related_organisation_id].nil? && @relationship.errors.on(:related_organisation_id).include?("can't be invalid"))
      flash.now[:error] = "Can't Be Same As Parent Organisation" if (!@relationship.errors[:related_organisation_id].nil? && @relationship.errors.on(:related_organisation_id).include?("can't be same as source organisation"))
      flash.now[:error] = "Can't Add Level 0 Organisaion" if (!@relationship.errors[:check_level].nil? && @relationship.errors.on(:check_level).include?("can't add level 0 organisaion"))
      flash.now[:error] = "Already had Organisation Relationship" if (!@relationship.errors[:check_level].nil? && @relationship.errors.on(:check_level).include?("already had organisaion relationship"))
      flash.now[:error] = "Already In the Relationship" if (!@relationship.errors[:same_organistion_family].nil? && @relationship.errors.on(:same_organistion_family).include?("organisiton already in family"))
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
    #to set the flag for delete level zero org or other org
    @zero_org=false
    @source_organisation = Organisation.find(params[:id].to_i)
    if @source_organisation.level == 0
      @zero_org = true
      unless @source_organisation.related_organisations.empty?
        @related_organisation = OrganisationRelationship.find_by_source_organisation_id(params[:id])
      end

      @source_organisation.level=nil
      @source_organisation.family_id = nil
      @source_organisation.save
    else
      @related_organisation = OrganisationRelationship.find_by_related_organisation_id(params[:id])
    end
    
    @organisation = @source_organisation
    @level = @organisation.level
    @next_level = (@level.to_i)+1


    @related_organisation.destroy unless @related_organisation.nil?
    #    OrganisationRelationship.delete_all_relationship(params[:id].to_i)
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted Relationship ")
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
    @organisation = Organisation.find(params[:grid_object_id]) rescue @organisation = nil
    @level = @organisation.level rescue @level = 0
    @next_level = (@level.to_i)+1    
    if @organisation.try(:family_id) == 1
      @next_level_label = ClientSetup.send("client_label_#{@next_level}")
    else
      @next_level_label = ClientSetup.send("label_#{@next_level}")
    end
    @reset = "<a href='#' onclick=';return false;' class='organisation_relationship_reset' grid_object_id='#{@organisation.source_organisations.try(:first).try(:id) if @level!=0}'><img src='/images/Reselect.png' alt='Reset'/></a>"
    respond_to do |format|
      format.js
    end
  end
  
end
