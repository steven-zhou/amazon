class ListDetailsController < ApplicationController
  # System Logging Added
 
  def destroy    
    @list_detail = ListDetail.find(params[:id].to_i)
    @list_header = @list_detail.list_header
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted ListDetail ID #{@list_detail.id}.")
    @list_detail.destroy
    @entity = @list_header.person_list? ? "person" : "organisation"
    @list_header.source = @list_header.source.nil? ? "Updated" : @list_header.source.chomp(" & Updated") + " & Updated"
    @list_header.save
    respond_to do |format|
      format.js
    end
  end

  def create
    @list_detail = ListDetail.new(:list_header_id => params[:list_header_id], :entity_id => params[:entity_id])
    @list_header = ListHeader.find(params[:list_header_id])

    if @list_header.person_list?
      add_to_person_list
      @entity = "person"
      @lists = @current_user.all_person_lists
    else
      add_to_organisation_list
      @entity = "organisation"
      @lists = @current_user.all_organisation_lists
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def add_to_person_list
    person_ids = Array.new
    @list_header.list_details.each do |i|
      person_ids << i.entity_id
    end
    dup = person_ids.include?(params[:entity_id].to_i)
    @new_record = Person.find(params[:entity_id]) rescue @new_record = Person.new
    if !@new_record.new_record?
      if (!dup || @list_header.allow_duplication)
        @list_detail.save
        @list_header.source = @list_header.source.nil? ? "Updated" : @list_header.source.chomp(" & Updated") + " & Updated"
        @list_header.save
        system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) added a new List Detail #{@list_detail.id}.")
        #add new record to grid

        @leg = ListEditGrid.new
        @leg.login_account_id = session[:user]
        @leg.grid_object_id = @new_record.id
        @leg.field_1 = @new_record.first_name
        @leg.field_2 = @new_record.family_name
        @leg.save

        @list_header = ListHeader.find(params[:list_header_id])
      else
        flash.now[:error] = flash_message(:message => "Duplications are not allowed")
      end
    else
      flash.now[:error] = flash_message(:message => "Person ID is Invalid")
    end
  end

  def add_to_organisation_list
    organisation_ids = Array.new
    @list_header.list_details.each do |i|
      organisation_ids << i.entity_id
    end
    dup = organisation_ids.include?(params[:entity_id].to_i)
    @new_record = Organisation.find(params[:entity_id].to_i) rescue @new_record = Organisation.new
    if !@new_record.new_record?
      if (!dup || @list_header.allow_duplication)
        @list_detail.save
        @list_header.source = @list_header.source.nil? ? "Updated" : @list_header.source.chomp(" & Updated") + " & Updated"
        @list_header.save
        system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) added a new List Detail #{@list_detail.id}.")
        #add new record to grid

        @leg = ListEditGrid.new
        @leg.login_account_id = session[:user]
        @leg.grid_object_id = @new_record.id
        @leg.field_1 = @new_record.full_name
        @leg.field_2 = @new_record.trading_as
        @leg.save

        @list_header = ListHeader.find(params[:list_header_id])
      else
        flash.now[:error] = flash_message(:message => "Duplications are not allowed")
      end
    else
      flash.now[:error] = flash_message(:message => "Organisation ID is Invalid")
    end
  end

end
