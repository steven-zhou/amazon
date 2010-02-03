class ContactsController < ApplicationController
  # System loggin added here, it took several hours of work!
  def page_initial
    @render_page = params[:render_page]
    @field = params[:field]
    if params[:type]=="Person"
      @person = Person.find_by_id(params[:params1])
    else
      @organisation = Organisation.find_by_id(params[:params1])
    end
    @phone = Phone.new
    @email = Email.new
    @fax = Fax.new
    @website = Website.new
    @instant_messaging = InstantMessaging.new
    
    
    respond_to do |format|
      format.js
    end
  end

end
