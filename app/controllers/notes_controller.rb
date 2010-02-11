class NotesController < ApplicationController
  # System Logging added

  def create
    if params[:type] == "Person"
    @entity = Person.find(params[:entity_id].to_i)
    end
    if params[:type] == "Organisation"
      @entity = Organisation.find(params[:entity_id].to_i)
    end

    @note = @entity.notes.new(params[:note])
  
    if @note.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new Note #{@note.id}.")
    else
      flash.now[:error]= "Please Enter All Required Data"if(!@note.errors[:label].nil? && @note.errors.on(:label).include?("can't be blank"))
      flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "label") if (!@note.errors.on(:label).nil? && @note.errors.on(:label).include?("has already been taken"))
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
    @note.destroy
    @entity = @note.noteable
        system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted Note #{@note.id}.")
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
    if params[:type]=="Person"
      @type = "Person"
      @person = Person.find_by_id(params[:params1])
    else
      @type = "Organisation"
      @organisation = Organisation.find_by_id(params[:params1])
    end
    @note = Note.new
    @note.active = true

    respond_to do |format|
      format.js
    end
  end


  def new_note_form
   if params[:param2] == "Person"
   @person = Person.find_by_id(params[:param1])
   end

    if params[:param2] == "Organisation"
      @organisation = Organisation.find_by_id(params[:param1])
    end

   @note = Note.new
    respond_to do |format|
      format.js
    end
  end

end
