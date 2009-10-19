class DataManagersController < ApplicationController

  def import_index
    respond_to do |format|
      format.html
    end
  end

  def export_index
    @queries = QueryHeader.saved_queries
    @lists = ListHeader.saved_lists
    respond_to do |format|
      format.html
    end
  end

end
