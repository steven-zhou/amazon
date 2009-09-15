class TagMetaTypesController < ApplicationController

  def new
    @tag_meta_type = (TagMetaType::OPTIONS[params[:tag].to_i]+"MetaMetaType").camelize.constantize.new
    respond_to do |format|
      format.js
    end
  end

  def edit
    @tag_meta_type = (TagMetaType::OPTIONS[params[:tag].to_i]+"MetaMetaType").camelize.constantize.find(params[:id])
    @tag_types = @tag_meta_type.tag_types.find(:all, :order => "name")
    @tag_type = (TagMetaType::OPTIONS[params[:tag].to_i]+"MetaType").camelize.constantize.new
    @flag = String.new
    @flag = params[:flag]
    respond_to do |format|
      format.js
    end
  end

  def create
    @tag_meta_type = params[:type].camelize.constantize.new(params[params[:type].underscore.to_sym])
    if @tag_meta_type.save
      flash.now[:message] = "Saved successfully"
    else
      #flash.now[:error] = "Name " + @tag_meta_type.errors.on(:name)[0] + ", saved unsuccessfully" unless @tag_meta_type.errors.on(:name).nil?
      flash.now[:error] = flash_message(:type => "field_missing", :field => "name") if (!@tag_meta_type.errors[:name].nil? && @tag_meta_type.errors.on(:name)[0] == "can't be blank")
      flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "name") if (!@tag_meta_type.errors[:name].nil? && @tag_meta_type.errors.on(:name)[0] == "has already been taken")
    end
    respond_to do |format|
      format.js
    end
  end

  def update
    @tag_meta_type = params[:type].camelize.constantize.find(params[:id].to_i)
    if @tag_meta_type.update_attributes(params[params[:type].underscore.to_sym])
      flash.now[:message] = "Updated successfully."
    else
      flash.now[:error] = flash_message(:type => "field_missing", :field => "name") if (!@tag_meta_type.errors[:name].nil? && @tag_meta_type.errors.on(:name)[0] == "can't be blank")
      flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "name") if (!@tag_meta_type.errors[:name].nil? && @tag_meta_type.errors.on(:name)[0] == "has already been taken")
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @tag_meta_type = (TagMetaType::OPTIONS[params[:tag].to_i]+"MetaMetaType").camelize.constantize.find(params[:id])
    @tag_meta_type.destroy

    respond_to do |format|
      format.js
    end
  end



end
