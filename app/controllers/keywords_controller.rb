class KeywordsController < ApplicationController
  # System Logging done

  def new

  end

  def create
    @keyword_table = Keyword.new
    @keyword_table.name = params[:keyword][:name]
    @keyword_table.description = params[:keyword][:description]
    @keyword_table.status = params[:keyword][:status]
    @keyword_table.keyword_type_id = params[:type_id]
    @keyword_table.save
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new Keyword with ID #{@keyword_table.id}.")

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
   
    @keyword_table.update_attributes(params[:keyword])
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated Keyword with ID #{@keyword_table.id}.")

    @keyword_table.save
   

    respond_to do |format|
      format.js  
    end

  end



  def destroy
    keyword = Keyword.find(params[:id])

     system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted Keyword with ID #{keyword.id}.")
         keyword.destroy

    respond_to do |format|
      format.js
    end
  end

  def keywords_finder
    @type = Keyword.find_all_by_keyword_type_id(params[:type])

    #@type = Keyword.find(:all, :conditions => ["keyword_type_id = ?", params[:type]], :order => 'name')
    respond_to do |format|
      format.js
    end

  end

  def check_destroy
    keyword = Keyword.find(params[:id])
    @keyword_assigned = KeywordLink.find_by_keyword_id(keyword.id)
    @keyword_id = params[:id]
    respond_to do |format|
      format.js
    end
  end

  def keyword_name_show
    @keywords = Keyword.find_all_by_keyword_type_id(params[:keyword_type_id])
      @keyword = String.new
     
    for keyword in @keywords    
      @keyword += "<option value=#{keyword.id}>#{keyword.name}</option>"
    end
    respond_to do |format|
      format.js
    end
  end

end
