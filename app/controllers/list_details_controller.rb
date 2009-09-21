class ListDetailsController < ApplicationController

 
  def destroy    
    @list_detail = ListDetail.find(params[:id].to_i)
    @list_header = @list_detail.list_header
    @list_detail.destroy
    
    @list_header.source = @list_header.source.nil? ? "Updated" : @list_header.source.chomp(" & Updated") + " & Updated"
    @list_header.save
    respond_to do |format|
      format.js
    end
  end

  def create
    @list_detail = ListDetail.new(:list_header_id => params[:list_header_id], :person_id => params[:person_id])
    @list_header = ListHeader.find(params[:list_header_id])
    if @list_header.allow_duplication
      @list_detail.save
      @list_header.source = @list_header.source.nil? ? "Updated" : @list_header.source.chomp(" & Updated") + " & Updated"
      @list_header.save
    else
      flash.now[:error] = flash_message(:message => "Duplications are not allowed")
    end
    
    respond_to do |format|
      format.js
    end
  end

end
