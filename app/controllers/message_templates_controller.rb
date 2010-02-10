class MessageTemplatesController < ApplicationController



  def show

  end

  def new
    
  end

  def create


  end

  def update

  end

  def destroy

  end

  def page_initial
    @render_page = params[:render_page]
    @field = params[:field]
    respond_to do |format|
      format.js
    end
  end

end
