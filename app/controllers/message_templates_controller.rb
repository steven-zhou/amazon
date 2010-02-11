class MessageTemplatesController < ApplicationController



  def show

  end

  def new
    @mail_template = MailTemplate.new
    @type = params[:param1]
    
    @table_attributes = TableMetaMetaType.table_categroy(@type)
  
    respond_to do |format|
      format.js
    end
    
  end

  def create
    @mail_template = MailTemplate.new(params[:mail_template])
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
    @mail_template = MailTemplate.find(params[:id])
    @table_attributes = TableMetaMetaType.table_categroy("person")

    respond_to do |format|
      format.js
    end
  end

  def update
    @mail_template = MailTemplate.find(params[:id])
    if @mail_template.update_attributes(params[:mail_template])

    else

    end

    respond_to do |format|
      format.js
    end
    

  end

  def destroy

  end

  def page_initial
    @render_page = params[:render_page]
    @field = params[:field]
    @type = params[:type]
    respond_to do |format|
      format.js
    end
  end



end
