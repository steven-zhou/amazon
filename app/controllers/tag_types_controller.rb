class TagTypesController < ApplicationController
  # System Log is done...

  def new
    @tag_type = (params[:tag]+"MetaType").camelize.constantize.new
    @tag_meta_type = (params[:tag]+"MetaMetaType").camelize.constantize.find(params[:tag_meta_type_id])
    @tag_types = @tag_meta_type.tag_types
    respond_to do |format|
      format.js
    end
  end

  def create
    @tag_type = (params[:type]).camelize.constantize.new(params[params[:type].underscore.to_sym])
    @tag_type.to_be_removed = false
    @category = params[:type].sub(/MetaType/,"")
    @tag_meta_type = (params[:tag_meta_type]).camelize.constantize.find(params[:tag_meta_type_id])
    @tag_meta_type.tag_types << @tag_type
    if @tag_type.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created Tag Type #{@tag_type.id}.")
      flash.now[:message] ||= " Saved successfully"
    else
      flash.now[:error] = flash_message(:type => "field_missing", :field => "name") if (!@tag_type.errors.on(:name).nil? && @tag_type.errors.on(:name)[0] == "can't be blank")
      flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "name") if (!@tag_type.errors.on(:name).nil? && @tag_type.errors.on(:name)[0] == "has already been taken")
    end
  end

  def edit
    @tag_type = TagType.find(params[:id])
    @tag_meta_type = @tag_type.tag_meta_type
    respond_to do |format|
      format.js
    end
  end

  def update
    @tag_type = (params[:type]).camelize.constantize.find(params[:id].to_i)
    @category = params[:type].sub(/MetaType/,"")
    @tag_meta_type = @tag_type.tag_meta_type
    if @tag_type.update_attributes(params[params[:type].underscore.to_sym])
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated Tag Type #{@tag_type.id}.")
      flash.now[:message] ||= " Updated successfully."
    else
      flash.now[:error] = flash_message(:type => "field_missing", :field => "name") if (!@tag_type.errors.on(:name).nil? && @tag_type.errors.on(:name)[0] == "can't be blank")
      flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "name") if (!@tag_type.errors.on(:name).nil? && @tag_type.errors.on(:name)[0] == "has already been taken")
    end
    respond_to do |format|
      format.js
    end
  end

  def show_tag_types
    @tag_meta_type = (TagMetaType::OPTIONS[params[:tag].to_i]+"MetaMetaType").camelize.constantize.find(params[:id])
    @tag_types = @tag_meta_type.tag_types.find(:all, :order => "name")
    respond_to do |format|
      format.js
    end
  end

  def show_fields
    @tag_types = TableMetaType.find(:all, :conditions => ["tag_meta_type_id=? and status =true", TableMetaMetaType.find_by_name(params[:table_name]).id], :order => "name")
    @update_field = String.new
    @update_value = String.new
    @update_field = params[:update_field]
    @update_value = params[:update_value]
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @tag_type = TagType.find(params[:id])
    @tag_type.to_be_removed = true
     @tag_type.save
    @tag_meta_type = @tag_type.tag_meta_type
    @category = @tag_type.type.to_s.sub(/MetaType/,"")
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted Tag Type #{@tag_type.id}.")
    #    @tag_type.destroy
    #    @tag_types = (@tag_type.type.camelize.constantize).find(:all, :order => "name asc")
    respond_to do |format|
      format.js
    end
  end




  def show_types
    @group_meta_type = GroupMetaType.find(params[:group_meta_type_id].to_i) rescue @group_meta_type = GroupMetaType.new
    @group_types = @group_meta_type.group_types.find(:all,:conditions => ["status = true"], :order => "name")
    respond_to do |format|
      format.js
    end
  end

  def custom_groups_finder
    @custom_groups = GroupMetaMetaType.find_by_name("Custom")
    respond_to do |format|
      format.js
    end
  end

  def create_group_meta_type
    @custom_group = GroupMetaMetaType.find_by_name("Custom")
    @group_meta_type = GroupMetaType.new(:tag_meta_type_id => @custom_group.id)
    @group_meta_type.update_attributes(params[:group_meta_type])
    if @group_meta_type.save
      flash.now[:message] = "Saved successfully."
    else
      flash.now[:warning] = "Name " + @group_meta_type.errors.on(:name)[0] + ", saved unsuccessfully." unless @group_meta_type.errors.on(:name).nil?
    end
    respond_to do |format|
      format.js
    end
  end

  def security_groups_finder
    @security_groups = GroupMetaMetaType.find_by_name("Security")
    respond_to do |format|
      format.js
    end
  end

  def create_security_group_meta_type
    @security_group = GroupMetaMetaType.find_by_name("Security")
    @group_meta_type = GroupMetaType.new(:tag_meta_type_id => @security_group.id)
    @group_meta_type.update_attributes(params[:group_meta_type])
    if @group_meta_type.save
      flash.now[:message] = "Saved successfully."
    else
      flash.now[:warning] = "Name " + @group_meta_type.errors.on(:name)[0] + ", saved unsuccessfully." unless @group_meta_type.errors.on(:name).nil?
    end
    respond_to do |format|
      format.js
    end
  end

  def security_groups_finder
    @security_groups = GroupMetaMetaType.find_by_name("Security")
    respond_to do |format|
      format.js
    end
  end

  def create_security_group_meta_type
    @security_group = GroupMetaMetaType.find_by_name("Security")
    @group_meta_type = GroupMetaType.new(:tag_meta_type_id => @security_group.id)
    @group_meta_type.update_attributes(params[:group_meta_type])
    if @group_meta_type.save
      flash.now[:message] = "Saved successfully."
    else
      flash.now[:warning] = "Name " + @group_meta_type.errors.on(:name)[0] + ", saved unsuccessfully." unless @group_meta_type.errors.on(:name).nil?
    end
    respond_to do |format|
      format.js
    end
  end

  def query_tables_finder
    @query_tables = TableMetaMetaType.find(:all)
    respond_to do |format|
      format.js
    end
  end

  def create_query_table_meta_meta_type
    @query_table = TableMetaMetaType.new
    @query_table.update_attributes(params[:table_meta_meta_type])
    if @query_table.save
      flash.now[:message] = "Saved successfully."
    else
      flash.now[:warning] = "Name " + @query_table.errors.on(:name)[0] + ", saved unsuccessfully." unless @query_table.errors.on(:name).nil?
    end
    respond_to do |format|
      format.js
    end
  end


  def delete_custom_group_type
    custom_group = GroupMetaType.find(params[:id])
    custom_group.destroy
    @custom_groups = GroupMetaMetaType.find_by_name("Custom")
    respond_to do |format|
      format.js
    end
  end  

  def show_receipt_type
    @receipt_meta_type = ReceiptMetaMetaType.find(params[:param1])
    @receipt_types = ReceiptMetaType.find(:all, :conditions => ['tag_meta_type_id = ? ', params[:param1]])
    @action = params[:type] #new or edit
    @options = ""
    @receipt_types.each do |i|
      @options += '<option value=' + i.id.to_s + '>' + i.name
    end
    @cheque_detail = ChequeDetail.new
    @credit_card_detail = CreditCardDetail.new
    respond_to do |format|
      format.js
    end
  end


  def retrieve
    @tag_type = TagType.find(params[:id])
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) retrieve Master Docs ID #{@tag_type.id}.")

    @tag_type.retrieve_all_children
    @tag_meta_type = @tag_type.tag_meta_type
    @category = @tag_type.type.to_s.sub(/MetaType/,"")
    respond_to do |format|
      format.js
    end
  end
  
end

