class AmazonSettingsController < ApplicationController
  # System Logging done...

  def new
    @amazonsetting = params[:type].camelize.constantize.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @amazonsetting = params[:type].camelize.constantize.new(params[params[:type].underscore.to_sym])
    if @amazonsetting.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new Amazon Setting with ID #{@amazonsetting.id}.")
      flash[:message] = "Saved successfully."

    else

      flash[:warning] = "Name " + @amazonsetting.errors.on(:name)[0] + ", saved unsuccessfully." unless @amazonsetting.errors.on(:name).nil?
    end
    respond_to do |format|
      format.js
    end
  end

  def edit
    @amazonsetting = AmazonSetting.find(params[:id].to_i)
    respond_to do |format|
      format.js
    end
  end

  def update
    @amazonsetting = AmazonSetting.find(params[:id].to_i)
    @amazonsetting.update_attributes(params[params[:type].underscore.to_sym])
    if @amazonsetting.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated Amazon Setting with ID #{@amazonsetting.id}.")
      flash[:message] = "Updated successfully."
    else
      flash[:warning] = "Name " + @amazonsetting.errors.on(:name)[0] + ", updated unsuccessfully." unless @amazonsetting.errors.on(:name).nil?
    end
    respond_to do |format|
      format.js
    end
  end

  def data_list_finder
    @amazonsettings = AmazonSetting.find(:all, :conditions => ["type = ?", params[:type]], :order => 'name')
    @amazonsetting = AmazonSetting.find(params[:id].to_i) rescue @amazonsetting = AmazonSetting.new
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @amazonsetting = AmazonSetting.find(params[:id].to_i)
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted Amazon Setting ID #{@amazonsetting.id}.")
    @amazonsetting.destroy
    @amazonsetting = AmazonSetting.distinct_setting_type
    respond_to do |format|
      format.js
    end
  end

  def system_settings_finder
    @amazon_settings = AmazonSetting.find(:all, :conditions => ["type = ?", params[:type]], :order => 'name')
    respond_to do |format|
      format.js
    end
  end

  def system_data_entry_finder
    @amazon_setting = AmazonSetting.find_by_id(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def new_setting
    @amazon_setting = params[:amazon_setting][:type].camelize.constantize.new
    @amazon_setting.update_attributes(params[:amazon_setting])
    @amazon_setting.to_be_removed = false
    if @amazon_setting.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new Amazon Setting with ID #{@amazon_setting.id}.")
      flash.now[:message] = "Saved successfully."
    else
      flash.now[:warning] = flash_message(:type => "field_missing", :field => "name") if (!@amazon_setting.errors.on(:name).nil? && @amazon_setting.errors.on(:name).include?("can't be blank"))
      flash.now[:warning] = flash_message(:type => "uniqueness_error", :field => "name") if (!@amazon_setting.errors.on(:name).nil? && @amazon_setting.errors.on(:name).include?("has already been taken"))
    end
    respond_to do |format|
      format.js
    end
  end

  def update_setting
    @amazon_setting = AmazonSetting.find(params[:id].to_i)
    @amazon_setting.update_attributes(params[params[:type].underscore.to_sym])
    if @amazon_setting.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated Amazon Setting with ID #{@amazon_setting.id}.")
      flash.now[:message] = flash_message(:type => "object_updated_successfully", :object => "setting")
    else
      flash.now[:warning] = flash_message(:type => "field_missing", :field => "name") if (!@amazon_setting.errors.on(:name).nil? && @amazon_setting.errors.on(:name).include?("can't be blank"))
      flash.now[:warning] = flash_message(:type => "uniqueness_error", :field => "name") if (!@amazon_setting.errors.on(:name).nil? && @amazon_setting.errors.on(:name).include?("has already been taken"))
    end
    respond_to do |format|
      format.js
    end
  end

  def delete_system_data_entry
    amazon_setting = AmazonSetting.find(params[:id])
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted Amazon Setting ID #{amazon_setting.id}.")
    #amazon_setting.destroy

    #if 'to_be_removed' is true, then this recored will be physically deleted from database in maintaince prgress
    amazon_setting.to_be_removed = true
    amazon_setting.save!
    respond_to do |format|
      format.js
    end
  end


  def new_keyword
    
    @keyword_table = Keyword.new{params[:keyword]}
    @keyword_table.type_id = params[:type_id]
    @keyword_table.save

    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new keyword with ID #{@keyword_table.id}.")
  end

  def retrieve
    amazon_setting = AmazonSetting.find(params[:id])
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) retrieve Amazon Setting ID #{amazon_setting.id}.")
    amazon_setting.to_be_removed = false
    amazon_setting.save!
    respond_to do |format|
      format.js
    end
  end

end
