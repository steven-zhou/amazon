class ReligionsController < ApplicationController
  # System Logging done...

  def new
    @religion = Religion.new
    respond_to do |format|
      format.js
    end
  end

  def edit
    @religion = Religion.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def create
    @religion = Religion.new(params[:religion])
    @religion.status = true
    if @religion.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new Religion entry with ID #{@religion.id}.")
    else

    end
    respond_to do |format|
      format.js
    end
  end

  def update
    @religion = Religion.find(params[:id])
    if @religion.update_attributes(params[:religion])
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated the details for Religion with ID #{@religion.id}.")
    else

    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @religion = Religion.find(params[:id])
    @religion.destroy
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted Religion with ID #{@religion.id}.")
    respond_to do |format|
      format.js
    end
  end
end
