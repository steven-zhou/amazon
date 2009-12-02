class AllocationTypesController < ApplicationController
  def new_allocation_type
    @allocation_type = AllocationType.new
    respond_to do |format|
      format.js
    end
  end

  def create_allocation_type
    @allocation_type = AllocationType.new(params[:allocation_type])
    @allocation_type.link_module_name = LinkModule.find_by_id(params[:allocation_type][:link_module_id]).name
    if @allocation_type.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new allocation type with ID #{@allocation_type.id}.")
    else
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to create a allocation type.")
      if(!@allocation_type.errors[:name].nil?)
        flash.now[:error] = "Please Enter A Unique Name"
      elsif(!@allocation_type.errors[:link_module_id].nil?)
        flash.now[:error] = "Please Select A Receipt Account Type"
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def edit_allocation_type
    @allocation_type = AllocationType.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def update_allocation_type
    @allocation_type = AllocationType.find(params[:id])
   params[:allocation_type][:link_module_name] = LinkModule.find_by_id(params[:allocation_type][:link_module_id]).name
    if @allocation_type.update_attributes(params[:allocation_type])
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated a new allocation_type with ID #{@allocation_type.id}.")
    else
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to update a receipt account #{@allocation_type.id}.")
      if(!@allocation_type.errors[:name].nil?)
        flash.now[:error] = "Please Enter A Unique Name"
      elsif(!@allocation_type.errors[:link_module_id].nil?)
        flash.now[:error] = "Please Select A Receipt Account Type"
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def copy_allocation_type
    @allocation_type = AllocationType.find(params[:id].to_i)
    respond_to do |format|
      format.js
    end
  end


  def create_copy_of_allocation_type
    @allocation_type_old = AllocationType.find(params[:source_id].to_i)
    @allocation_type = AllocationType.new
    @allocation_type.name = params[:allocation_type][:name]
    @allocation_type.description = params[:allocation_type][:description]
    @allocation_type.link_module_id = @allocation_type_old.link_module_id
    @allocation_type.link_module_name = @allocation_type_old.link_module_name
    @allocation_type.post_to_history = @allocation_type_old.post_to_history
    @allocation_type.post_to_campaign = @allocation_type_old.post_to_campaign
    @allocation_type.send_receipt = @allocation_type_old.send_receipt
    @allocation_type.status = @allocation_type_old.status
    @allocation_type.remarks = @allocation_type_old.remarks

    if @allocation_type.save

      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new receipt account #{@allocation_type.id}.")
      flash.now[:message] = flash_message(:type => "object_created_successfully", :object => "receipt account")
    else
      flash.now[:error] = flash_message(:type => "field_missing", :field => "name") if (!@allocation_type.errors.nil? && @allocation_type.errors.on(:name).include?("can't be blank"))
      flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "name") if (!@allocation_type.errors.nil? && @allocation_type.errors.on(:name).include?("has already been taken"))
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy_allocation_type
    @allocation_type = AllocationType.find(params[:id])
    @allocation_type.destroy
    respond_to do |format|
      format.js
    end
  end



end
