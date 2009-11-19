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

    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @language = Language.find(params[:id])
    @language.destroy
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted Language with ID #{@language.id}.")
    respond_to do |format|
      format.js
    end
  end

  def show_languages
    @languages = Language.find(:all, :order => 'name')
    @update = params[:update]
    respond_to do |format|
      format.js
    end
  end
end
