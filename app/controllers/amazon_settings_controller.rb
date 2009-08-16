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
      flash[:message] = "The type was saved."
    else
      flash[:warning] = "The type was not saved."
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
      flash[:message] = "The type was updated successfully."
    else
      flash[:warning] = "The type was not updated successfully."
    end
    respond_to do |format|
      format.js
    end
  end

  def data_list_finder
    @amazonsetting = AmazonSetting.find_all_by_type(params[:type])
    respond_to do |format|
      format.js
    end
  end
end
