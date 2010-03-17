class ExtrasController < ApplicationController



  def page_initial
    @render_page = params[:render_page]
    @field = params[:field]
    @extra = Extra.new
   
    if params[:type]=="Person"
      @type = "Person"
      @person = Person.find_by_id(params[:params1])
    else
      @type = "Organisation"
      @organisation = Organisation.find_by_id(params[:params1])
    end

    respond_to do |format|
      format.js
    end
  end
end
