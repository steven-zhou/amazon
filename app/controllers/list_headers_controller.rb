class ListHeadersController < ApplicationController

  def create
    if (params[:type]=="StaticList")
      @query_header = QueryHeader.find(params[:query_header_id].to_i)
      @static_list = StaticList.new(params[:list_header])
      person_ids = Array.new
      person_ids = params[:person_id]
      @static_list.query_header_id = @query_header.id
      @static_list.list_size = person_ids.size
      @static_list.created_at = Date.today()
      @static_list.last_date_generated = Date.today()
      @static_list.status = true
      StaticList.transaction do
        if @static_list.save
          
          person_ids.each_value do |i|
            @list_detail = ListDetail.new(:list_header_id => @static_list.id, :person_id => i)
            if @list_detail.save
              flash.now[:message] = "Save Successfully"
            else
              flash.now[:error] = "can't save details"
            end
          end
        else
          flash.now[:error] = "can't save list"
        end

      end
      
    else
      @dynamic_list = DynamicList.new(params[:list_header])
      DynamicList.transaction do
        if @dynamic_list.save
          person_ids = Array.new
          person_ids = params[:person_id].compact
          person_ids.each do |i|
            @list_detail = ListDetail.new(:list_header_id => @dynamic_list.id, :person_id => i)
            if @list_detail.save
              flash.now[:message] = "Save Successfully"
            else
              flash.now[:error] = "can't save details"
            end
          end
        else
          flash.now[:error] = "can't save list"
        end

      end
    end
    respond_to do |format|
      format.js
    end
  end
end
