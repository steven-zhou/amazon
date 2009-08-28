class NotesController < ApplicationController

  before_filter :check_authentication

  def create
    @entity = Person.find(params[:person_id].to_i) rescue Organisation.find(params[:organisation_id].to_i)
    @note = @entity.notes.new(params[:note])
  
    @note.save
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
      respond_to do |format|
        format.js
      end
    end
  end

end
