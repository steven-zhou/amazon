class ExtrasController < ApplicationController



  def page_initial
    @render_page = params[:render_page]
    @field = params[:field]
    @groups = ExtraMetaType.active
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


  
end
