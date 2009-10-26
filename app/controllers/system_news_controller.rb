class SystemNewsController < ApplicationController

  def create
    @system_news = SystemNews.new(params[:system_news])
    @system_news.save
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @system_news = SystemNews.find(params[:id].to_i)
    @system_news.destroy
    respond_to do |format|
      format.js
    end
  end
end
