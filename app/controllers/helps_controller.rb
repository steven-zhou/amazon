class HelpsController < ApplicationController
  def show
    @help = Help.find_by_controller_and_action(params[:current_controller],params[:current_action])
    respond_to do |format|
      format.js
    end
  end

  def search
    search_content = "%"+params[:search_content]+"%"
    @help_array = Help.find_by_sql(["SELECT * FROM helps WHERE title ilike ? or keyword ilike ? or content ilike ?", search_content, search_content, search_content])
    @help_array.uniq
    respond_to do |format|
      format.js
    end
  end
end
