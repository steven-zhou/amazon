class LanguagesController < ApplicationController
  # System Logging done...

  def new
    @language = Language.new
    respond_to do |format|
      format.js
    end
  end

  def edit
    @language = Language.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def create
    @language = Language.new(params[:language])
    @language.status = true
    if @language.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new Language entry with ID #{@language.id}.")
    else
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to create a language record.")
      #----------------------------presence - of----
      if(!@language.errors[:name].nil? && @language.errors.on(:name).include?("can't be blank"))
         flash.now[:error] = "Please Enter All Required Data"

        #-----------------------uniqueness - of -----------------------
      else(!@language.errors[:name].nil? && @language.errors.on(:name).include?("has already been taken"))
          flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "name")
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def update
    @language = Language.find(params[:id])
    if @language.update_attributes(params[:language])
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated the details for Language with ID #{@language.id}.")
    else
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to update a language record.")
      #----------------------------presence - of----
      if(!@language.errors[:name].nil? && @language.errors.on(:name).include?("can't be blank"))
         flash.now[:error] = "Please Enter All Required Data"

        #-----------------------uniqueness - of -----------------------
      else(!@language.errors[:name].nil? && @language.errors.on(:name).include?("has already been taken"))
          flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "name")
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @language = Language.find(params[:id])
#    @language.destroy

    @language.to_be_removed = true
    @language.save
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted Language with ID #{@language.id}.")
    respond_to do |format|
      format.js
    end
  end
    def retrieve_language
    @language = Language.find(params[:id])
#    @language.destroy

    @language.to_be_removed = false
    @language.save
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) retrieved Language with ID #{@language.id}.")
    respond_to do |format|
      format.js
    end
  end

  def show_languages
    @languages = Language.all
    @update = params[:update]
    respond_to do |format|
      format.js
    end
  end
end
