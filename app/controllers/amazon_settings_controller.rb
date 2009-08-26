class AmazonSettingsController < ApplicationController

  before_filter :check_authentication

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
      flash[:warning] = "Name " + @amazonsetting.errors.on(:name)[0] + ", saved unsuccessfully."
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
      flash[:warning] = "Name " + @amazonsetting.errors.on(:name)[0] + ", updated unsuccessfully."
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
end
