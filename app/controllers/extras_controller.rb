class ExtrasController < ApplicationController



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
