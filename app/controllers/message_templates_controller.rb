class MessageTemplatesController < ApplicationController



  def show

  end

  def new
    @mail_template = params[:param1] == "person" ? PersonMailTemplate.new : OrganisationMailTemplate.new
    @type = params[:param1]
    
    @table_attributes = TableMetaMetaType.table_categroy(@type)
  
    respond_to do |format|
      format.js
    end
    
  end

  def create
    @mail_template = (params[:type]+"_mail_template").camelize.constantize.new(params[:mail_template])
    @type = params[:type]
    @model_type = (params[:type]+"_mail_template").camelize
    #    if @mail_template.save
    #      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new mail template with ID #{@mail_template.id}.")
    #    else
    #      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to create a new mail template.")
    #    end
    @mail_template.save!

    respond_to do |format|
      format.js
    end
  end

  def edit
    @mail_template = MessageTemplate.find(params[:id])
    #@table_attributes = @mail_template.class.to_s == "PersonMailTemplate" ? TableMetaMetaType.table_categroy("person") : TableMetaMetaType.table_categroy("organisation")
    @type = params[:params2]
    @table_attributes = TableMetaMetaType.table_categroy(@type)

    respond_to do |format|
      format.js
    end
  end

  def update
    @mail_template = MessageTemplate.find(params[:id])
    if @mail_template.update_attributes(params[:mail_template])

    else

    end
    @type = params[:type]
    @model_type = (params[:type]+"_mail_template").camelize

    respond_to do |format|
      format.js
    end
    

  end



  def page_initial
    @render_page = params[:render_page]
    @field = params[:field]
    @type = params[:type]
    @model_type = (params[:type]+"_mail_template").camelize
   
    respond_to do |format|
      format.js
    end
  end

  def drop_down_list
    @tag_types = TableMetaType.mmt_name_finder(params[:level1_value])
    @drop_down_field = params[:drop_down_field]
    respond_to do |format|
      format.js
    end

  end

  def retrieve_mail_template
    @mail_template = MessageTemplate.find(params[:id])
    @mail_template.to_be_removed = false
    @mail_template.save!
    @type = (@mail_template.class.to_s == "PersonMailTemplate")? "person" : "organisation"
    @model_type = (@type+"_mail_template").camelize
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) retrieve Mail Template ID #{@mail_template.id}.")
    respond_to do |format|
      format.js
    end


  end

  def destroy_mail_template
    @mail_template = MessageTemplate.find(params[:id]) 
    @mail_template.to_be_removed = true
    @mail_template.save!
    @type = (@mail_template.class.to_s == "PersonMailTemplate")? "person" : "organisation"
    @model_type = (@type+"_mail_template").camelize
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted Mail Template ID #{@mail_template.id}.")
    respond_to do |format|
      format.js
    end
  end



end
