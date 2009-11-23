class ListDetailsController < ApplicationController
  # System Logging Added
 
  def destroy    
    @list_detail = ListDetail.find(params[:id].to_i)
    @list_header = @list_detail.list_header
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted ListDetail ID #{@list_detail.id}.")
    @list_detail.destroy
    
    @list_header.source = @list_header.source.nil? ? "Updated" : @list_header.source.chomp(" & Updated") + " & Updated"
    @list_header.save
    respond_to do |format|
      format.js
    end
  end

  def create
    @list_detail = ListDetail.new(:list_header_id => params[:list_header_id], :person_id => params[:person_id])
    @list_header = ListHeader.find(params[:list_header_id])
    person_ids = Array.new
    @list_header.list_details.each do |i|
      person_ids << i.person_id
    end
    dup = person_ids.include?(params[:person_id].to_i)
    @new_record = Person.find(params[:person_id]) rescue @new_record = Person.new
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
      flash.now[:error] = flash_message(:message => "Person ID is not valid")
    end
    respond_to do |format|
      format.js
    end
  end

end
