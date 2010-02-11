class KeywordsController < ApplicationController
  # System Logging done

  def new

  end

  def create
    @keyword_table = Keyword.new
    #    @keyword_table.name = params[:keyword][:name]
    #    @keyword_table.description = params[:keyword][:description]
    #    @keyword_table.status = params[:keyword][:status]
    @keyword_table.update_attributes(params[:keyword])
    @keyword_table.keyword_type_id = params[:type_id]
    @keyword_table.to_be_removed = false
    if @keyword_table.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new Keyword with ID #{@keyword_table.id}.")
    else
      flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "Keyword")
    end

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
    #    @keyword_table.save
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated Keyword with ID #{@keyword_table.id}.")

    respond_to do |format|
      format.js  
    end

  end



  def destroy
    keyword = Keyword.find(params[:id])

    keyword.to_be_removed = true
    keyword.save!
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted Keyword with ID #{keyword.id}.")
    # keyword.destroy

    respond_to do |format|
      format.js
    end
  end

  def delete_keywords
    keyword = Keyword.find(params[:id])

    keyword.to_be_removed = true
    keyword.save!
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted Keyword with ID #{keyword.id}.")
    # keyword.destroy

    respond_to do |format|
      format.js
    end
  end

  def keywords_finder
    @type = Keyword.all_keyword_type_by_type(params[:type])
    
    #@keyword_type is used for grid in _keyword_entries.html.haml.
    @keyword_type_id = params[:type]
    
    #@type = Keyword.find(:all, :conditions => ["keyword_type_id = ?", params[:type]], :order => 'name')
    respond_to do |format|
      format.js
    end

  end

  def check_destroy
    keyword = Keyword.find(params[:id])
    @keyword_assigned = KeywordLink.check_existing(keyword.id)
    @keyword_id = params[:id]
    respond_to do |format|
      format.js
    end
  end

  def keyword_name_show
    #    @keywords = Keyword.find_all_by_keyword_type_id(params[:keyword_type_id])
    @keywords = Keyword.all_keyword_type_by_type(params[:keyword_type_id])
    @keyword = String.new
     
    for keyword in @keywords    
      @keyword += "<option value=#{keyword.id}>#{keyword.name}</option>"
    end
    respond_to do |format|
      format.js
    end
  end

  def keyword_des_show
    @keyword= Keyword.find(params[:id].to_i)
    respond_to do |format|
      format.js
    end
  end


  def retrieve
    keyword = Keyword.find(params[:id])
    keyword.to_be_removed = false
    keyword.save!
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) retrieve Keyword with ID #{keyword.id}.")
    respond_to do |format|
      format.js
    end

  end

  def page_initial
    @render_page = params[:render_page]
    @field = params[:field]
    if params[:type]=="Person"
      @type = "Person"
      @person = Person.find_by_id(params[:params1])
    else
      @type = "Organisation"
      @organisation = Organisation.find_by_id(params[:params1])
    end
    respond_to do |format|
      format.js
    end
  end



end
