class NotesController < ApplicationController
  # System Logging added

  def create
    @entity = Person.find(params[:person_id].to_i) rescue Organisation.find(params[:organisation_id].to_i)
    @note = @entity.notes.new(params[:note])
  
    if @note.save
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new Note #{@note.id}.")
    else
      flash.now[:error]= "Please Enter All Required Data"if(!@note.errors[:label].nil? && @note.errors.on(:label).include?("can't be blank"))
    end
    respond_to do |format|
      format.js
    end
  end

  def show
    @note = Note.find(params[:id].to_i)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @note = Note.find(params[:id].to_i)
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted Note #{@note.id}.")
    @note.destroy
    respond_to do |format|
      format.js
    end
  end

  def edit
    @note = Note.find(params[:id].to_i)
    respond_to do |format|
      format.js
    end
  end

  def update
    @note = Note.find(params[:id].to_i)
    if @note.update_attributes(params[:note]["#{@note.id}"])
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) edited Note #{@note.id}.")
    else
      flash.now[:error]= "Please Enter All Required Data"if(!@note.errors[:label].nil? && @note.errors.on(:label).include?("can't be blank"))
    end
      respond_to do |format|
        format.js
      end
    
  end

end
