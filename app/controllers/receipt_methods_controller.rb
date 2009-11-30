class ReceiptMethodsController < ApplicationController
  
  def new_receipt_method
    @receipt_method = ReceiptMethod.new
    respond_to do |format|
      format.js
    end
  end

  def create_receipt_method
    @receipt_method = ReceiptMethod.new(params[:receipt_method])
    if @receipt_method.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new receipt method with ID #{@receipt_method.id}.")
    else
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to create a receipt method.")
      if(!@receipt_method.errors[:name].nil?)
         flash.now[:error] = "Please Enter A Unique Name"
      elsif(!@receipt_method.errors[:receipt_method_type_id].nil?)
         flash.now[:error] = "Please Select A Receipt Method Type"
      end
    end


    respond_to do |format|
      format.js
    end
  end

  def update_receipt_method
    @receipt_method = ReceiptMethod.find(params[:id])
    if @receipt_method.update_attributes(params[:receipt_method])
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated a new receipt method with ID #{@receipt_method.id}.")
    else
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to update a receipt method #{@receipt_method.id}.")
      if(!@receipt_method.errors[:name].nil?)
         flash.now[:error] = "Please Enter A Unique Name"
      elsif(!@receipt_method.errors[:receipt_method_type_id].nil?)
         flash.now[:error] = "Please Select A Receipt Method Type"
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def edit_receipt_method
    @receipt_method = ReceiptMethod.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def copy_receipt_method
    @receipt_method = ReceiptMethod.find(params[:id].to_i)
    respond_to do |format|
      format.js
    end
  end

  def create_copy_of_receipt_method
    @receipt_method_old = ReceiptMethod.find(params[:source_id].to_i)
    @receipt_method = ReceiptMethod.new
    @receipt_method.name = params[:receipt_method][:name]
    @receipt_method.description = params[:receipt_method][:description]
    @receipt_method.receipt_method_type_id = @receipt_method_old.receipt_method_type_id
    @receipt_method.status = @receipt_method_old.status
    @receipt_method.remarks = @receipt_method_old.remarks
    @receipt_method.card_merchant_number = @receipt_method_old.card_merchant_number
    @receipt_method.card_name = @receipt_method_old.card_name
    @receipt_method.card_location = @receipt_method_old.card_location
    @receipt_method.card_cost = @receipt_method_old.card_cost
    @receipt_method.card_floor_limit = @receipt_method_old.card_floor_limit
    @receipt_method.card_lines_per_page = @receipt_method_old.card_lines_per_page

    if @receipt_method.save

      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new receipt method #{@receipt_method.id}.")
      flash.now[:message] = flash_message(:type => "object_created_successfully", :object => "receipt method")
    else
      flash.now[:error] = flash_message(:type => "field_missing", :field => "name") if (!@receipt_method.errors.nil? && @receipt_method.errors.on(:name).include?("can't be blank"))
      flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "name") if (!@receipt_method.errors.nil? && @receipt_method.errors.on(:name).include?("has already been taken"))
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy_receipt_method
    @receipt_method = ReceiptMethod.find(params[:id])
    @receipt_method.destroy
    respond_to do |format|
      format.js
    end    
  end

end
