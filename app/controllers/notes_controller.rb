class NotesController < ApplicationController


  def create
    @person = Person.find(params[:person_id])
    @note = @person.notes.new(params[:note])
  
    @note.save
    respond_to do |format|
      format.js
    end
  end

  def show
    @note = Note.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    respond_to do |format|
      format.js
    end
  end

  def edit
    @note = Note.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def update
    @note = Note.find(params[:id])
    if @note.update_attributes(params[:note]["#{@note.id}"])
      respond_to do |format|
        format.js
      end
    end
  end

end
