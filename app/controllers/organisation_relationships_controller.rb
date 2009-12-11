class OrganisationRelationshipsController < ApplicationController

   def create

    @source_organisation = Organisation.find(params[:organisation_id].to_i)
    @organisation = @source_organisation
    @relationship = OrganisationRelationship.new(params[:organisation_relationship])


    if @relationship.save
       @organisation = Organisation.find(params[:organisation_id].to_i)
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created Organisation Relationship #{@relationship.id}.")
      flash.now[:message]= "saved successfully"
      
    else
#      flash.now[:error] = "Please Enter Current Organisation ID"

      flash.now[:error] = "Please Enter All Required Data"if (!@relationship.errors[:related_organisation_id].nil? && @relationship.errors.on(:related_organisation_id).include?("can't be blank"))
      flash.now[:error] = "Please Check Organisation Level " if (!@relationship.errors[:related_organisation_id].nil? && @relationship.errors.on(:related_organisation_id).include?("can't be invalid"))
      flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "related_person")if (!@relationship.errors[:related_organisation_id].nil? && @relationship.errors.on(:related_organisation_id).include?("has already been taken"))
#      flash.now[:error] = flash_message(:type => "not exist", :field => "related_person")if (!@relationship.errors[:related_person_id].nil? && @relationship.errors.on(:related_person_id).include?("can't be invalid"))
    end

     @relationship_new = Relationship.new
    respond_to do |format|
      format.js{}
    end
  end

   def destroy
    puts "11111111111111111111"
    @source_organisation = Organisation.find(params[:id].to_i)
    puts @source_organisation.id
puts "11111111111111111112"
puts "11111111111111111113"
    @organisation = Organisation.find(params[:id].to_i)
puts "11111111111111111114"
    @organisation_relationship = OrganisationRelationship.find(params[:related_organisation_id].to_i)
    puts @organisation_relationship
puts "11111111111111111115"
   @relationship = OrganisationRelationship.find_by_source_organisation_id(@source_organisation.id)
   
    @organisation_relationship.destroy
     puts "11111111111111111117"
     system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted Relationship ")
    puts "11111111111111111116"
    @relationship_new = Relationship.new
puts "11111111111111111117"
    respond_to do |format|
      format.js
    end
  end

  
end
