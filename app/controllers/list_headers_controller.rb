class ListHeadersController < ApplicationController

  def create

    if(params[:person_id])
        person_ids = Array.new
        person_ids = params[:person_id]

        if (params[:type]=="StaticList")
          @query_header = QueryHeader.find(params[:query_header_id].to_i)
          @static_list = StaticList.new(params[:list_header])
          @static_list.query_header_id = @query_header.id
          @static_list.list_size = person_ids.size
          @static_list.created_at = Date.today()
          @static_list.last_date_generated = Date.today()
          @static_list.status = true

          StaticList.transaction do
            if @static_list.save
              person_ids.each_value do |i|
                @list_detail = ListDetail.new(:list_header_id => @static_list.id, :person_id => i)
                @list_detail.save
              end
              flash.now[:message] = flash_message(:type => "object_created_successfully", :object => "static list")
            else
              flash.now[:error] = flash_message(:type => "field_missing", :field => "name") if (!@static_list.errors.on(:name).nil? && @static_list.errors.on(:name).include?("can't be blank"))
              flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "name") if (!@static_list.errors.on(:name).nil? && @static_list.errors.on(:name).include?("has already been taken"))
            end
          end



        else
          @query_header = QueryHeader.find(params[:query_header_id].to_i)
          @dynamic_list = DynamicList.new(params[:list_header])
          @dynamic_list.query_header_id = @query_header.id
          @dynamic_list.list_size = person_ids.size
          @dynamic_list.created_at = Date.today()
          @dynamic_list.last_date_generated = Date.today()
          @dynamic_list.status = true

          DynamicList.transaction do
            if @dynamic_list.save
              person_ids.each do |i|
                @list_detail = ListDetail.new(:list_header_id => @dynamic_list.id, :person_id => i)
                @list_detail.save
              end
              flash.now[:message] = flash_message(:type => "object_created_successfully", :object => "dynamic list")
            else
              flash.now[:error] = flash_message(:type => "field_missing", :field => "name") if (!@dynamic_list.errors.on(:name).nil? && @dynamic_list.errors.on(:name).include?("can't be blank"))
              flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "name") if (!@dynamic_list.errors.on(:name).nil? && @dynamic_list.errors.on(:name).include?("has already been taken"))
            end

          end
        end



    else


      flash.now[:error] = "list can't be empty"

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
end
