class AmazonSettingsController < ApplicationController

  def new
    @amazonsetting = params[:type].camelize.constantize.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @amazonsetting = params[:type].camelize.constantize.new(params[params[:type].underscore.to_sym])
    if @amazonsetting.save
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
    if @amazon_setting.save
      flash.now[:message] = "Saved successfully."
    else
      flash.now[:warning] = "Name " + @amazon_setting.errors.on(:name)[0] + ", saved unsuccessfully." unless @amazon_setting.errors.on(:name).nil?
    end
    respond_to do |format|
      format.js
    end
  end

  def update_setting
    @amazon_setting = AmazonSetting.find(params[:id].to_i)
    @amazon_setting.update_attributes(params[params[:type].underscore.to_sym])
    if @amazon_setting.save
      flash.now[:message] = flash_message(:type => "object_updated_successfully", :object => "setting")
    else
      flash.now[:warning] = flash_message(:type => "default", :message => "There was an error updating the setting.")
    end
    respond_to do |format|
      format.js
    end
  end

  def delete_system_data_entry
    amazon_setting = AmazonSetting.find(params[:id])
    amazon_setting.destroy
    respond_to do |format|
      format.js
    end
  end


end
