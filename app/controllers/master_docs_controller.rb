class MasterDocsController < ApplicationController
  def show
    @masterdoc = MasterDoc.find(params[:id])
    render "show.js"
  end

  def create
    @person = Person.find(params[:person_id])
    @masterdoc = @person.master_docs.new(params[:master_doc])
    @masterdoc.save
    #create.js should also handle the error
    render "create.js"
  end

  def edit
    @masterdoc = MasterDoc.find(params[:id])
    render "edit.js"
  end

  def update
    @masterdoc = MasterDoc.find(params[:id])
    @masterdoc.update_attributes(params[:master_doc][@masterdoc.id.to_s])
    #create.js should also handle the error
    render "show.js"
  end

  def destroy
    @masterdoc = MasterDoc.find(params[:id])
    @masterdoc.destroy
    render "destroy.js"
  end
end
