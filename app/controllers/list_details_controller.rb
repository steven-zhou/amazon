class ListDetailsController < ApplicationController

 
  def destroy    
    @list_detail = ListDetail.find(params[:id].to_i)
    @list_header = @list_detail.list_header
    @list_detail.destroy
    respond_to do |format|
      format.js
    end
  end

  def create
    @list_detail = ListDetail.new(:list_header_id => params[:list_header_id], :person_id => params[:person_id])
    @list_header = ListHeader.find(params[:list_header_id])
    @list_detail.save
    respond_to do |format|
      format.js
    end
  end

end
