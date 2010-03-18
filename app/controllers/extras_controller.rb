class ExtrasController < ApplicationController
  # System Log stuff added
  def page_initial
    @render_page = params[:render_page]
    @field = params[:field]
    @extra_types = ExtraMetaType.active
    if params[:type]=="Person"
      @type = "Person"
      @person = Person.find_by_id(params[:params1])
      @entity = @person
    else
      @type = "Organisation"
      @organisation = Organisation.find_by_id(params[:params1])
      @entity = @organisation
    end

    respond_to do |format|
      format.js
    end
  end

  def create
    @extra = Extra.new(params[:extra])
    if @extra.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new extra entry with ID #{@extra.id}.")
    else

    end
    @group = @extra.group
    @position = @group.try(:position)
    respond_to do |format|
      format.js
    end
  end

  def edit
    @extra = Extra.find(params[:id])
    @group = @extra.group
    @position = @group.try(:position)
    @entity = @extra.entity
    respond_to do |format|
      format.js
    end
  end
  
  def update
    @extra = Extra.find(params[:id])
    if @extra.update_attributes(params[:extra])
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated the details for extra with ID #{@extra.id}.")
    else

    end
    @group = @extra.group
    @position = @group.try(:position)
    @entity = @extra.entity
    respond_to do |format|
      format.js
    end
  end

  def show
    @extra = Extra.find(params[:id])
    @group = @extra.group
    @position = @group.try(:position)
    @entity = @extra.entity
    respond_to do |format|
      format.js
    end
  end
  
end
