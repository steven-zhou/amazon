class MasterDocsController < ApplicationController
  # System Logging added

  def show
    @masterdoc = MasterDoc.find(params[:id])
    render "show.js"
  end

  def create
    @entity = Person.find(params[:person_id].to_i) rescue Organisation.find(params[:organisation_id].to_i)
      check_issue_date = params[:master_doc][:issue_date].blank? ? true : valid_date(params[:master_doc][:issue_date])
        check_expiry_date = params[:master_doc][:expiry_date].blank? ? true : valid_date(params[:master_doc][:expiry_date])
    @masterdoc = @entity.master_docs.new(params[:master_doc])

    if check_issue_date&&check_expiry_date

    if @masterdoc.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new MasterDoc #{@masterdoc.id}.")
      #create.js should also handle the error
#      render "create.js"
    else
      #      flash.now[:error]= flash_message(:type => "field_missing", :field => "login_id")if(!@user_group.errors[:user_id].nil? && @user_group.errors.on(:user_id).include?("can't be blank"))
      flash.now[:error]= "Please Enter All Required Data"if(!@masterdoc.errors[:doc_number].nil? && @masterdoc.errors.on(:doc_number).include?("can't be blank"))
      flash.now[:error]= "Please Enter All Required Data"if(!@masterdoc.errors[:master_doc_type_id].nil? && @masterdoc.errors.on(:master_doc_type_id).include?("can't be blank"))
      flash.now[:error]= flash_message(:type => "uniqueness_error", :field => "Doc Number")if(!@masterdoc.errors[:doc_number].nil? && @masterdoc.errors.on(:doc_number).include?("has already been taken"))
#      render "create.js"
    end

    else
      flash.now[:error] = "Please make sure the start date and end date are entered in valid format (dd-mm-yyyy)"
      end
    render "create.js"
  end

  def edit
    @masterdoc = MasterDoc.find(params[:id])
    @masterdoctype = @masterdoc.master_doc_type
    @masterdocmetatype = @masterdoctype.master_doc_meta_type
    @masterdocmetametatype = @masterdocmetatype.master_doc_meta_meta_type

    #use following array to store the types for the select option list in view.
    #MasterDocTypeArray contains all the types of MasterDoc, i.e. Passport, Driver Licence.
    @MasterDocTypeArray =  MasterDocType.find(:all, :conditions => ["tag_type_id = ? and status=true", @masterdocmetatype.id]) rescue @master_doc_types = Array.new
    #MasterDocMetaTypeArray contains all the meta type of MasterDocType, i.e. Government Issued
    @MasterDocMetaTypeArray = MasterDocMetaType.find(:all, :conditions => ["tag_meta_type_id = ? and status=true ", @masterdocmetametatype.id]) rescue @master_doc_meta_types = Array.new
    render "edit.js"
  end

  def update
        @masterdoc = MasterDoc.find(params[:id])
        check_issue_date = params[:master_doc][@masterdoc.id.to_s][:issue_date].blank? ? true : valid_date(params[:master_doc][@masterdoc.id.to_s][:issue_date])
        check_expiry_date = params[:master_doc][@masterdoc.id.to_s][:expiry_date].blank? ? true : valid_date(params[:master_doc][@masterdoc.id.to_s][:expiry_date])

    if check_issue_date&&check_expiry_date
    if @masterdoc.update_attributes(params[:master_doc][@masterdoc.id.to_s])
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) edited MasterDoc #{@masterdoc.id}.")
      #create.js should also handle the error

    else
      flash.now[:error]= "Please Enter All Required Data"if(!@masterdoc.errors[:doc_number].nil? && @masterdoc.errors.on(:doc_number).include?("can't be blank"))
      flash.now[:error]= "Please Enter All Required Data"if(!@masterdoc.errors[:master_doc_type_id].nil? && @masterdoc.errors.on(:master_doc_type_id).include?("can't be blank"))
      flash.now[:error]= flash_message(:type => "uniqueness_error", :field => "Doc Number")if(!@masterdoc.errors[:doc_number].nil? && @masterdoc.errors.on(:doc_number).include?("has already been taken"))

    end
      else
      flash.now[:error] = "Please make sure the start date and end date are entered in valid format (dd-mm-yyyy)"
      end
      render "show.js"
  end

  def destroy
    @masterdoc = MasterDoc.find(params[:id])
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted MasterDoc #{@masterdoc.id}.")
    @masterdoc.destroy
    if @masterdoc.entity_type == "Person"             # if in Person return person object to destroy.js
      @current_object = Person.find(@masterdoc.entity_id)
    end
    if @masterdoc.entity_type == "Organisation"
      @current_object =Organisation.find(@masterdoc.entity_id)  # if in organisation return organisation object to destroy.js
    end
    render "destroy.js"
  end

  def move_down_master_doc_priority
    @current_master_doc = MasterDoc.find(params[:id])

    if(@current_master_doc.priority_number==1)
      @exchange_master_doc = @current_master_doc.entity.master_docs.find_by_priority_number(2)

      @exchange_master_doc.priority_number = 1
      @current_master_doc.priority_number = 2
      @exchange_master_doc.save
      @current_master_doc.save
    end
    @person = Person.find(@current_master_doc.entity_id)
    respond_to do |format|
      format.js
    end

  end

  def move_up_master_doc_priority
    @up_current_master_doc = MasterDoc.find(params[:id])
    @up_exchange_master_doc = @up_current_master_doc.entity.master_docs.find_by_priority_number(@up_current_master_doc.priority_number - 1)

    @up_exchange_master_doc.priority_number = @up_exchange_master_doc.priority_number + 1
    @up_current_master_doc.priority_number = @up_current_master_doc.priority_number - 1

    @up_exchange_master_doc.save
    @up_current_master_doc.save
    @person = Person.find(@up_current_master_doc.entity_id)

    respond_to do |format|
      format.js
    end

  end

  def move_organisation_down_master_doc_priority

    @current_master_doc = MasterDoc.find(params[:id])

    if(@current_master_doc.priority_number==1)
      @exchange_master_doc = @current_master_doc.entity.master_docs.find_by_priority_number(2)

      @exchange_master_doc.priority_number = 1
      @current_master_doc.priority_number = 2
      @exchange_master_doc.save
      @current_master_doc.save
    end
    @organisation = Organisation.find(@current_master_doc.entity_id)
    respond_to do |format|
      format.js
    end

  end

  def move_organisation_up_master_doc_priority
    @up_curren_master_doc = MasterDoc.find(params[:id])
    @up_exchange_master_doc = @up_curren_master_doc.entity.master_docs.find_by_priority_number(@up_curren_master_doc.priority_number - 1)

    @up_exchange_master_doc.priority_number = @up_exchange_master_doc.priority_number + 1
    @up_curren_master_doc.priority_number = @up_curren_master_doc.priority_number - 1

    @up_exchange_master_doc.save
    @up_curren_master_doc.save
    @organisation = Organisation.find(@up_curren_master_doc.entity_id)
    respond_to do |format|
      format.js
    end
  end

  def page_initial
    @render_page = params[:render_page]
    @field = params[:field]
    @masterdoc = MasterDoc.new
     if params[:type]=="Person"
       @type = "Person"
      @person = Person.find_by_id(params[:params1])
    else
      @type = "Organsition"
      @organisation = Organisation.find_by_id(params[:params1])
    end

    respond_to do |format|
      format.js
    end
  end

end
