class QuickLaunchIconsController < ApplicationController



  def create
    @quick_launch_icons = QuickLaunchIcon.new
    @quick_launch_icons.controller = params[:controller]
    @quick_launch_icons.action  = params[:action]
    @quick_launch_icons.image_url = params[:image_url]
    @quick_launch_icons.title = params[:title]
    @quick_launch_icons.login_account_id = @current_user.id
    if @quick_launch_icons.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new quick launch id #{@quick_launch_icons.id}.")
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



  
end
