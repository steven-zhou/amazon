class GroupListsController < ApplicationController

  def show_lists

    @group_type = GroupType.find(params[:group_id])
    #@list_headers = @group_type.list_headers
    @group_list = GroupList.new
    @group_lists = @group_type.group_lists
   
    respond_to do |format|
      format.js
    end
  end


  def create
  
    @group_list = GroupList.new(params[:group_list])
    if @group_list.save
      flash.now[:message]= "saved successfully"
    else
      flash.now[:error] = flash_message(:type => "field_missing", :field => "tag_id")if (!@group_list.errors[:tag_id].nil? && @group_list.errors.on(:tag_id).include?("can't be blank"))
      flash.now[:error] = flash_message(:type => "field_missing", :field => "list_header_id")if (!@group_list.errors[:list_header_id].nil? && @group_list.errors.on(:list_header_id).include?("can't be blank"))
      flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "list_header_id")if(!@group_list.errors[:list_header_id].nil? && @group_list.errors.on(:list_header_id).include?("has already been taken"))
    end
    @group_type = GroupType.find(params[:group_list][:tag_id])
    @group_lists = @group_type.group_lists
    @list_headers = @group_type.list_headers
    respond_to do |format|
      format.js
    end
  end

  def destroy
      
    @group_list = GroupList.find(params[:id].to_i)
    @group_list.destroy

    respond_to do |format|
      format.js
    end
  end

end
