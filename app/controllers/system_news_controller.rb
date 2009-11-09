class SystemNewsController < ApplicationController

  def index
    @active_system_news = SystemNews.find(:all, :conditions => ["status = ?", true], :order => "created_at")
    @inactive_system_news = SystemNews.find(:all, :conditions => ["status = ?", false], :order => "created_at")
  end

  def create
    @system_news = SystemNews.new(params[:system_news])
    @system_news.status = true
    if @system_news.save
      system_log("#{@current_user.user_name} post a new news(ID - #{@system_news.id})")
    else
      flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "title") if (!@system_news.errors[:title].nil? && @system_news.errors.on(:title) == "has already been taken")
      flash.now[:error] = flash_message(:type => "field_missing", :field => "title") if (!@system_news.errors[:title].nil? && @system_news.errors.on(:title) == "can't be blank")
      flash.now[:error] = flash_message(:type => "field_missing", :field => "description") if (!@system_news.errors[:description].nil? && @system_news.errors.on(:description) == "can't be blank")
    end
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

  def switch
    @system_news = SystemNews.find(params[:id].to_i)
    if @system_news.status
      @system_news.status = false
    else
      @system_news.status = true
    end
    @system_news.save
    @active_system_news = SystemNews.find(:all, :conditions => ["status = ?", true], :order => "created_at")
    @inactive_system_news = SystemNews.find(:all, :conditions => ["status = ?", false], :order => "created_at")
    respond_to do |format|
      format.js
    end
  end

  def edit
    @system_news = SystemNews.find(params[:id].to_i)
    respond_to do |format|
      format.js
    end
  end

  def show
    @system_news = SystemNews.find(params[:id].to_i)
    respond_to do |format|
      format.js
    end
  end

  def update
    @system_news = SystemNews.find(params[:id].to_i)
    @system_news.update_attributes(params[:system_news])
    respond_to do |format|
      format.js
    end
  end

  def pre_three
    @current_news = SystemNews.find(:all, :conditions => ["status = ?", true], :order => "created_at DESC", :offset => (params[:news_offset_number].to_i-1)*3, :limit => 3)
    respond_to do |format|
      format.js
    end
  end

  def next_three
    @current_news = SystemNews.find(:all, :conditions => ["status = ?", true], :order => "created_at DESC", :offset => (params[:news_offset_number].to_i+1)*3, :limit => 3)
    respond_to do |format|
      format.js
    end
  end
end
