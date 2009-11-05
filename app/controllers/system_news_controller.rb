class SystemNewsController < ApplicationController

  def index
    @active_system_news = SystemNews.find(:all, :conditions => ["status = ?", true], :order => "created_at")
    @inactive_system_news = SystemNews.find(:all, :conditions => ["status = ?", false], :order => "created_at")
  end

  def create
    @system_news = SystemNews.new(params[:system_news])
    @system_news.status = true
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
