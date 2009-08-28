class MasterDocsController < ApplicationController

  before_filter :check_authentication

  def show
    @masterdoc = MasterDoc.find(params[:id])
    render "show.js"
  end

  def create
    @entity = Person.find(params[:person_id].to_i) rescue Organisation.find(params[:organisation_id].to_i)
    @masterdoc = @entity.master_docs.new(params[:master_doc])
    @masterdoc.save
    #create.js should also handle the error
    render "create.js"
  end

  def edit
    @masterdoc = MasterDoc.find(params[:id])
    @masterdoctype = @masterdoc.master_doc_type
    @masterdocmetatype = @masterdoctype.master_doc_meta_type
    @masterdocmetametatype = @masterdocmetatype.master_doc_meta_meta_type
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
