class ListHeadersController < ApplicationController

  def create
    if(params[:source_id]) #copy
      @list_header_old = ListHeader.find(params[:source_id].to_i)
      @list_header = @list_header_old.class.new(params[:list_header])
      @list_header.query_header_id = @list_header_old.query_header_id
      @list_header.allow_duplication = @list_header_old.allow_duplication
      @list_header.list_size = 0
      @list_header.source_type = "L" #copy from list
      @list_header.source = "Copy from List - #{@list_header_old.name}"
      @list_header.status = true
      @list_header.last_date_generated = Date.today()
      
      if @list_header.save
        ListHeader.transaction do
          @list_header_old.list_details.each do |i|
            @list_detail = ListDetail.new(:list_header_id => @list_header.id, :person_id => i.person_id)
            @list_detail.save
          end
        end

        flash.now[:message] = flash_message(:type => "object_created_successfully", :object => "list (copy)")
      else
        flash.now[:error] = flash_message(:type => "field_missing", :field => "name") if (!@list_header.errors.on(:name).nil? && @list_header.errors.on(:name).include?("can't be blank"))
        flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "name") if (!@list_header.errors.on(:name).nil? && @list_header.errors.on(:name).include?("has already been taken"))
      end

      
    else #create

      if(params[:person_id])
        person_ids = Array.new
        person_ids = params[:person_id]

        @query_header = QueryHeader.find(params[:query_header_id].to_i)
        @list_header = ListHeader.new(params[:list_header])
        @list_header.query_header_id = @query_header.id
        @list_header.last_date_generated = Date.today()
        @list_header.list_size = 0
        @list_header.source_type = "Q" #generate from query
        @list_header.source = "Generate by Query - #{@query_header.name}"
        @list_header.status = true

        ListHeader.transaction do
          if @list_header.save
            person_ids.each_value do |i|
              @list_detail = ListDetail.new(:list_header_id => @list_header.id, :person_id => i)
              @list_detail.save
            end
            flash.now[:message] = flash_message(:type => "object_created_successfully", :object => "list")
          else
            flash.now[:error] = flash_message(:type => "field_missing", :field => "name") if (!@list_header.errors.on(:name).nil? && @list_header.errors.on(:name).include?("can't be blank"))
            flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "name") if (!@list_header.errors.on(:name).nil? && @list_header.errors.on(:name).include?("has already been taken"))
          end
        end






      else


        flash.now[:error] = flash_message(:message => "list can't be empty")

      end


    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @list_header = ListHeader.find(params[:id].to_i)
    @list_header.destroy
    respond_to do |format|
      format.js
    end
  end

  def edit
    @list_header = ListHeader.find(params[:id].to_i)
    @list_details = @list_header.list_details
    @query_header = @list_header.query_header
    @people = @list_header.people_on_list
    respond_to do |format|
      format.js
    end
  end

  def update
    @list_header = ListHeader.find(params[:id].to_i)
    @list_header.update_attributes(params[:list_header])
    @list_header = ListHeader.find(@list_header)
    
    if !@list_header.allow_duplication  # if allow_duplication is change to be false

      delete_list = Array.new
      person_list = Array.new
      @list_header.list_details.each do |i|
        if person_list.include?(i.person_id)
          delete_list.push(i)
        else
          person_list.push(i.person_id)
        end
      end

      delete_list.each do |i|
        i.destroy
      end
    end
    @list_header = ListHeader.find(@list_header)
    respond_to do |format|
      format.js
    end
  end

  def copy
    @list_header = ListHeader.find(params[:id].to_i)
    respond_to do |format|
      format.js
    end
  end

  def delete_details
    params[:list_detail].each do |i|
      @list_detail = ListDetail.find(i.to_i)
      @list_detail.destroy
    end
    respond_to do |format|
      format.js
    end
  end
end
