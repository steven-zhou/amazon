class FeeItemsController < ApplicationController
  # System Log stuff added

  def new
    @fee_item = (params[:param1]).camelize.constantize.new
    
    if (params[:param1]== "SubscriptionFeeItem")
      @type = "subscription_fee"
      #@type_class= "SubscriptionFeeItem"
      @fee_item_meta_meta_types = SubscriptionFeeMetaMetaType.active
    else
      @type = "membership_fee"
     # @type_class= "MembershipFeeItem"
      @fee_item_meta_meta_types = MembershipFeeMetaMetaType.active
    end
    respond_to do |format|
      format.js
    end
  end

  def create

    @fee_item = params[:type].camelize.constantize.new(params[params[:type].underscore.to_sym])
    @fee_item.tag_type_id = params[:tag_type_id]
   
    if @fee_item.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new #{@fee_item.class.to_s} with ID #{@fee_item.id}.")
    else
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to create a new #{@fee_item.class.to_s}")
      #----------------------------presence - of--------------
      if(!@fee_item.errors[:name].nil? && @fee_item.errors.on(:name).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
        #-----------------------validate--uniqueness------------------------
      elsif(!@fee_item.errors[:name].nil? && @fee_item.errors.on(:name).include?("has already been taken"))
        flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "name")
      else
        flash.now[:error] = "Input Error"
      end
    end
  
    if (@fee_item.class.to_s == "SubscriptionFeeItem")
      @type = "subscription_fee"
      @type_class= "SubscriptionFeeItem"
    else
      @type = "membership_fee"
      @type_class= "MembershipFeeItem"
    end
    respond_to do |format|
      format.js
    end
  end

  def edit

    params[:type]=params[:params2]
    @fee_item = params[:type].camelize.constantize.find(params[:id])
    
    @fee_type = @fee_item.fee_type
    @fee_meta_type =  @fee_type.tag_type
    @fee_meta_meta_type = @fee_meta_type.tag_meta_type
    if (params[:type]== "SubscriptionFeeItem")
      @type = "subscription_fee"
     
      @fee_meta_meta_types = SubscriptionFeeMetaMetaType.all
      @fee_meta_types = @fee_meta_meta_type.tag_types
      @fee_types = @fee_meta_type.tags
    else
      @type = "membership_fee"

      @fee_meta_meta_types = MembershipFeeMetaMetaType.all
      @fee_meta_types = @fee_meta_meta_type.tag_types
      @fee_types = @fee_meta_type.tags
    end

    respond_to do |format|
      format.js
    end
  end

  def update
    @fee_item = FeeItem.find(params[:id].to_i)
    if @fee_item.update_attributes(params[params[:type].underscore.to_sym])
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated #{params[:type]} Setting with ID #{@fee_item.id}.")
    else
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to update #{params[:type]} Setting with ID #{ @fee_item.id}.")
      #----------------------------presence - of--------------
      if(!@fee_item.errors[:name].nil? && @fee_item.errors.on(:name).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
        #-----------------------validate--uniqueness------------------------
      elsif(!@fee_item.errors[:name].nil? && @fee_item.errors.on(:name).include?("has already been taken"))
        flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "name")
      else
        flash.now[:error] = "Input Error"
      end

    end
    if (params[:type]== "SubscriptionFeeItem")
      @type = "subscription_fee"
      @type_class= "SubscriptionFeeItem"
    else
      @type = "membership_fee"
      @type_class= "MembershipFeeItem"
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy

    respond_to do |format|
      format.js
    end
  end

  def retrieve

    respond_to do |format|
      format.js
    end
  end

  def page_initial
    @render_page = params[:render_page]
    @field = params[:field]
        if @field == "subscription_fee"
           @type_class= "SubscriptionFeeItem"
        else
          @type_class= "MembershipFeeItem"
        end
    respond_to do |format|
      format.js
    end
  end

  def drop_down_list_l1
    @tag_types = TagType.find(:all, :conditions => ["tag_meta_type_id=?", params[:level1_value]], :order => "name")
    @drop_down_field = params[:drop_down_field]
 
    respond_to do |format|
      format.js
    end
  end

  def drop_down_list_l2
    @tags = Tag.find(:all, :conditions => ["tag_type_id=?", params[:level2_value]], :order => "name")
    @drop_down_field = params[:drop_down_field]

    respond_to do |format|
      format.js
    end
  end
end
