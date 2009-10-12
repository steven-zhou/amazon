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

end
