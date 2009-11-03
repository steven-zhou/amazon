class KeywordsController < ApplicationController


  def new

  end

  def create
    @keyword_table = Keyword.new
    @keyword_table.name = params[:keyword][:name]
    @keyword_table.description = params[:keyword][:description]
    @keyword_table.status = params[:keyword][:status]
    #    puts "********#{params[:keyword]}***************"
    @keyword_table.keyword_type_id = params[:type_id]
    @keyword_table.save


    respond_to do |format|
      format.js
    end
  end


  def edit
    @keyword= Keyword.find(params[:id].to_i)
    respond_to do |format|
      format.js
    end
  end

  def update

    @keyword_table= Keyword.find(params[:id].to_i)
   
    if @keyword_table.status == true

      @keyword_table.name = params[:keyword][:name]
      @keyword_table.description = params[:keyword][:description]

      @keyword_table.status = params[:keyword][:status]
    else

      @keyword_table.status = params[:keyword][:status]
    end


    @keyword_table.save
   

    respond_to do |format|
      format.js  
    end

  end



  def destroy
    keyword = Keyword.find(params[:id])
 
      keyword.destroy
  
   
    respond_to do |format|
      format.js
    end
  end

  def keywords_finder
    @type = Keyword.find_all_by_keyword_type_id(params[:type])
    respond_to do |format|
      format.js
    end

  end

  def check_destroy
    keyword = Keyword.find(params[:id])
    @keyword_assigned = KeywordLink.find_by_keyword_id(keyword.id)
    respond_to do |format|
      format.js
    end
  end

  
end
