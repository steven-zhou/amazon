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
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to create a religion record.")
      #----------------------------presence - of----
      if(!@religion.errors[:name].nil? && @religion.errors.on(:name).include?("can't be blank"))
         flash.now[:error] = "Please Enter All Required Data"

        #-----------------------uniqueness - of -----------------------
      else(!@religion.errors[:name].nil? && @religion.errors.on(:name).include?("has already been taken"))
          flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "name")
      end
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
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to update a religion record.")
      #----------------------------presence - of----
      if(!@religion.errors[:name].nil? && @religion.errors.on(:name).include?("can't be blank"))
         flash.now[:error] = "Please Enter All Required Data"

        #-----------------------uniqueness - of -----------------------
      else(!@religion.errors[:name].nil? && @religion.errors.on(:name).include?("has already been taken"))
          flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "name")
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @religion = Religion.find(params[:id])
#    @religion.destroy
@religion.to_be_removed= true
@religion.save
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted Religion with ID #{@religion.id}.")
    respond_to do |format|
      format.js
    end
  end
    def retrieve_religion
    @religion = Religion.find(params[:id])
#    @religion.destroy
@religion.to_be_removed= false
@religion.save
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) retrieved Religion with ID #{@religion.id}.")
    respond_to do |format|
      format.js
    end
  end
end
