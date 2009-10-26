class MasterDocsController < ApplicationController

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



    if @masterdoc.entity_type == "Person"             # if in Person return person object to destroy.js
      @current_object = Person.find(session[:user])
    end
    if @masterdoc.entity_type == "Organisation"
      @current_object =Organisation.find(@masterdoc.entity_id)  # if in organisation return organisation object to destroy.js
    end
    render "destroy.js"
  end

  def move_down_master_doc_priority
    @current_master_doc = MasterDoc.find(params[:id])

    if(@current_master_doc.priority_number==1)
      @exchange_master_doc = @current_master_doc.entity.master_docs.find_by_priority_number(2)

      @exchange_master_doc.priority_number = 1
      @current_master_doc.priority_number = 2
      @exchange_master_doc.save
      @current_master_doc.save
    end
    @person = Person.find(session[:user])
    respond_to do |format|
      format.js
    end

  end

  def move_up_master_doc_priority
    @up_current_master_doc = MasterDoc.find(params[:id])
    @up_exchange_master_doc = @up_current_master_doc.entity.master_docs.find_by_priority_number(@up_current_master_doc.priority_number - 1)

     @up_exchange_master_doc.priority_number = @up_exchange_master_doc.priority_number + 1
     @up_current_master_doc.priority_number = @up_current_master_doc.priority_number - 1

    @up_exchange_master_doc.save
    @up_current_master_doc.save
    @person = Person.find(session[:user])

    respond_to do |format|
      format.js
    end

  end

  def move_organisation_down_master_doc_priority

      @current_master_doc = MasterDoc.find(params[:id])

    if(@current_master_doc.priority_number==1)
      @exchange_master_doc = @current_master_doc.entity.master_docs.find_by_priority_number(2)

      @exchange_master_doc.priority_number = 1
      @current_master_doc.priority_number = 2
      @exchange_master_doc.save
      @current_master_doc.save
    end
    @organisation = Organisation.find(@current_master_doc.entity_id)
    respond_to do |format|
      format.js
    end

  end

    def move_organisation_up_master_doc_priority
    @up_curren_master_doc = MasterDoc.find(params[:id])
    @up_exchange_master_doc = @up_curren_master_doc.entity.master_docs.find_by_priority_number(@up_curren_master_doc.priority_number - 1)

    @up_exchange_master_doc.priority_number = @up_exchange_master_doc.priority_number + 1
    @up_curren_master_doc.priority_number = @up_curren_master_doc.priority_number - 1

    @up_exchange_master_doc.save
    @up_curren_master_doc.save
     @organisation = Organisation.find(@up_curren_master_doc.entity_id)
    respond_to do |format|
      format.js
    end
  end
end
