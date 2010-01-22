class QuickLaunchIconsController < ApplicationController

  def create

    @quick_launch_icons = QuickLaunchIcon.new
    params[:icon_controller] = nil if params[:icon_controller] == "undefined"
    params[:icon_action] = nil if params[:icon_action] == "undefined"
    @quick_launch_icons.controller = params[:icon_controller]
    @quick_launch_icons.action  = params[:icon_action]
    @quick_launch_icons.image_url = params[:image_url]
    @quick_launch_icons.title = params[:title]
    @quick_launch_icons.module = params[:icon_module]
    @quick_launch_icons.login_account_id = @current_user.id
    if @quick_launch_icons.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new quick launch id #{@quick_launch_icons.id}.")
    else
      #----------------------------presence - of------------------------#
      if (!@quick_launch_icons.errors[:login_account_id].nil? && @quick_launch_icons.errors.on(:login_account_id).include?("has already been taken"))
        flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "this shortcut")
      elsif (!@quick_launch_icons.errors[:login_account_id].nil? && @quick_launch_icons.errors.on(:login_account_id).include?("8 quick launch icons only"))
        flash.now[:error] = flash_message(:message => "You can only have 8 quick launch icons.")
      end
    end

    respond_to do |format|
      format.js
    end
  end


  def destroy
    @quick_launch_icons = QuickLaunchIcon.find(params[:id].to_i)
    @quick_launch_icons.destroy
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted Quick Launch #{@quick_launch_icons.id}.")
    respond_to do |format|
      format.js
    end
  end


  def check
    @quick_launch_icons = QuickLaunchIcon.find(params[:id].to_i)
    session[:module] =  @quick_launch_icons.module
    if @quick_launch_icons.controller == "people"
      id = session[:current_person_id]
    elsif @quick_launch_icons.controller == "organisations"
      id = session[:current_organisation_id]
    else
      id = ""
    end

    if @quick_launch_icons.action == "index"
      redirect_to :controller =>@quick_launch_icons.controller
    else
      redirect_to :controller =>@quick_launch_icons.controller, :action => @quick_launch_icons.action, :id => id
    end
      

  end


  
end

