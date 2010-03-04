class TaxItemsController < ApplicationController


  def new
    @tax_item = TaxItem.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @tax_item = TaxItem.new(params[:tax_item])
    if @tax_item.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new tax_item with ID #{@tax_item.id}.")
    else
      if(!@tax_item.errors[:name].nil? && @tax_item.errors.on(:name).include?("has already been taken"))
        flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "short_name")
      else
        flash.now[:error] = "Please Enter All Required Data"
      end
    end  
    respond_to do |format|
      format.js
    end
  end

  def edit
    @tax_item = TaxItem.find(params[:id])
    respond_to do |format|
      format.js
    end
  end


  def update
    @tax_item = TaxItem.find(params[:id])
    if @tax_item.update_attributes(params[:tax_item])
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated a new tax_item with ID #{@tax_item.id}.")
    else
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to update a tax_item record.")
      if(!@tax_item.errors[:name].nil? && @tax_item.errors.on(:name).include?("has already been taken"))
        flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "short_name")
      else
        flash.now[:error] = "Please Enter All Required Data"
      end
    end
    respond_to do |format|
      format.js
    end
  end


  def destroy

     @tax_item = TaxItem.find(params[:id])

    @tax_item.to_be_removed = true
    @tax_item.save!
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted Tax Item with ID #{@tax_item.id}.")
    # keyword.destroy

    respond_to do |format|
      format.js
    end
  end


  def retrieve_tax_item

      @tax_item = TaxItem.find(params[:id])

    @tax_item.to_be_removed = false
    @tax_item.save!
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) retrieve Tax Item with ID #{@tax_item.id}.")
    # keyword.destroy

    respond_to do |format|
      format.js
    end

  end

end
