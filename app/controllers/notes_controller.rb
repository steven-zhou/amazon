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
    @entity = @note.noteable
    respond_to do |format|
      format.js
    end
  end

  def edit
    # @note = Note.find(params[:id].to_i)
    @note = Note.find(params[:grid_object_id])
    #@url = @note.id
    respond_to do |format|
      format.js
    end
  end

  def update
    @note = Note.find(params[:id].to_i)

    @entity = @note.noteable

    if @note.update_attributes(params[:note])
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) edited Note #{@note.id}.")
    else
      flash.now[:error]= "Please Enter All Required Data"if(!@note.errors[:label].nil? && @note.errors.on(:label).include?("can't be blank"))
    end
    respond_to do |format|
      format.js
    end
    
  end

  def note_update
    @note = Note.find(params[:id].to_i)
    @entity = @note.noteable
    if @note.active
      @note.note_type_id=params[:note_type_id][:note_typed]
      @note.label=params[:note_label][:idnote_edit_label]
      @note.short_description=params[:short_description_text_field][:idnote_edit_short_description]
      @note.body_text=params[:edit_note_body][:edit_note_body]
    end
    @note.active=params[:active][:active_check_box]

    #    if @note.update_attributes(params[:note]["#{@note.id}"])
    if @note.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) edited Note #{@note.id}.")
    else
      flash.now[:error]= "Please Enter All Required Data"if(!@note.errors[:label].nil? && @note.errors.on(:label).include?("can't be blank"))
    end
    respond_to do |format|
      format.js
    end
  end

  def page_initial
    @render_page = params[:render_page]
    @field = params[:field]
    @person = Person.find_by_id(params[:params1])
    @note = Note.new
    @note.active = TRUE

    respond_to do |format|
      format.js
    end
  end


  def new_note_form
   @person = Person.find_by_id(params[:param1])
   @note = Note.new
    respond_to do |format|
      format.js
    end
  end

end
