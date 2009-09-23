class PeopleController < ApplicationController
  
  include PeopleSearch

  skip_before_filter :verify_authenticity_token, :only => [:show, :edit]

  def new
    @person = Person.new
    @person.addresses.build
    @person.phones.build
    @person.faxes.build
    @person.emails.build
    @person.websites.build
    @image = Image.new
    respond_to do |format|
      format.html
    end
  end
  
  def show

    #    @user_lists = session[:login_account_info].user_lists
    #    @list_headers = ListHeader.find(:all, :include => [:user_lists], :conditions => ["user_lists.user_id=?", session[:user]])
    #
    #
    #    @person = @list_headers.first.players.first unless @list_headers.blank?
    #    @person = Person.new if @person.nil? || @list_headers.blank?

    @group_types = LoginAccount.find(session[:user]).group_types
    @list_headers = Array.new
    c = Array.new
    @group_types.each do |group_type|
      a = group_type.list_headers
      c += a
      @list_headers = c.uniq
        
    end

    #when it is cal show action
    if request.get?
      if @list_headers.blank?
        @list_header = ListHeader.new
        @person = Person.new
        @p = Array.new
      else
        if params[:id].nil? || params[:id] == "show" #when just jumping or change list
          @list_header = @list_headers.first
          session[:current_list_id] = @list_header.id
          @person = @list_headers.first.people_on_list.first unless @list_headers.blank?
          session[:current_person_id] = @person.id
          @person = Person.new if @person.nil?
          @p = Array.new
          @p = @list_header.people_on_list
        else  #when there is id come---click the narrow button
          unless session[:current_list_id].blank?
            @list_header = ListHeader.find(session[:current_list_id])
            @p = Array.new
            @p = @list_header.people_on_list
            @person = Person.find_by_id(params[:id].to_i)
            session[:current_person_id] = @person.id
            #else
          end
        end
      end
    end

  







    #    if params[:id].nil? || params[:id] == "show" #when just jumping or change list
    #      if @list_headers.blank?
    #        @list_header = ListHeader.new
    #        @person = Person.new
    #        @p = Array.new
    #      else
    #        @list_header = @list_headers.first
    #        #puts"---debug000#{@list_header.to_yaml}"
    #        session[:current_list_id] = @list_header.id
    #        @person = @list_headers.first.people_on_list.first unless @list_headers.blank?
    #        #puts"000000debug000#{@person.to_yaml}"
    #        session[:current_person_id] = @person.id
    #        @person = Person.new if @person.nil?
    #        @p = Array.new
    #        @p = @list_header.people_on_list
    #      end
    #    else                #when there is id come---click the narrow button
    #      @list_header = ListHeader.find(session[:current_list_id])
    #      @p = Array.new
    #      @p = @list_header.people_on_list
    #      @person = Person.find_by_id(params[:id].to_i)
    #      session[:current_person_id] = @person.id
    #    end
    #  end
    if request.post?
      @list_header = ListHeader.find(params[:list_header_id])
      params[:id] = params[:person_id] unless (params[:person_id].nil? || params[:person_id].empty?)

      c1 = Array.new
      c1 = @list_header.people_on_list
      @person = Person.find_by_id(params[:id].to_i)
      unless c1.include?(@person)
        @person = @list_header.people_on_list.first
      else
        @person
      end
      @p = Array.new
      @p = @list_header.people_on_list
      session[:current_list_id] = @list_header.id
      session[:current_person_id] = @person.id
    end

    @primary_phone = @person.primary_phone
    @primary_email = @person.primary_email
    @primary_fax = @person.primary_fax
    @primary_website = @person.primary_website
    @primary_address = @person.primary_address
    @primary_employment = @person.primary_employment
    @other_phones = @person.other_phones
    @other_emails = @person.other_emails
    @other_faxes = @person.other_faxes
    @other_websites = @person.other_websites
    @other_addresses = @person.other_addresses
    @notes = @person.notes
    @person_role = @person.person_roles
    respond_to do |format|
      format.html
    end
  end

  
  def edit
    @group_types = LoginAccount.find(session[:user]).group_types

    #@user_lists = session[:login_account_info].user_lists
    #@list_headers = ListHeader.find(:all, :include => [:user_lists], :conditions => ["user_lists.user_id=?", session[:user]])
    #@list_headers = ListHeader.find(:all, :include => [:group_lists, :group_types, :user_group], :conditions => ["user_groups.user_id=?", session[:user]])
    @list_headers = Array.new
    c = Array.new
    @group_types.each do |group_type|
      #a = ListHeader.find(:all, :include => [:group_lists], :conditions => ["group_lists.tag_id=?", group_type.id])
      a = group_type.list_headers
      c += a
      @list_headers = c.uniq
    end
    if request.get?
      if @list_headers.blank?
        @list_header = ListHeader.new
        @person = Person.new
        @p = Array.new
      else
        unless session[:current_list_id].blank? && session[:current_person_id].blank?
          if params[:id].blank? || params[:id] == "show"
            @list_header = ListHeader.find(session[:current_list_id])
            @p = Array.new
            @p = @list_header.people_on_list
            @person = Person.find(session[:current_person_id])
          else
            @list_header = ListHeader.find(session[:current_list_id])
            @p = Array.new
            @p = @list_header.people_on_list
            @person = Person.find_by_id(params[:id].to_i)
            session[:current_person_id] = @person.id
          end
        else
          @list_header = @list_headers.first
          session[:current_list_id] = @list_header.id
          @person = @list_headers.first.people_on_list.first unless @list_headers.blank?
          session[:current_person_id] = @person.id
          @person = Person.new if @person.nil?
          @p = Array.new
          @p = @list_header.people_on_list
        end
      end
    end


    #    if request.get?
    #      unless session[:current_list_id].blank? && session[:current_person_id].blank?
    #        if params[:id].blank? || params[:id] == "show"
    #          if @list_headers.blank?
    #            @list_header = ListHeader.new
    #            @person = Person.new
    #            @p = Array.new
    #          else
    #
    #            @list_header = ListHeader.find(session[:current_list_id])
    #            @p = Array.new
    #            @p = @list_header.people_on_list
    #            @person = Person.find(session[:current_person_id])
    #
    #          end
    #        else
    #          @list_header = ListHeader.find(session[:current_list_id])
    #          @p = Array.new
    #          @p = @list_header.people_on_list
    #          @person = Person.find_by_id(params[:id].to_i)
    #          session[:current_person_id] = @person.id
    #        end
    #
    #      else
    #
    #        if @list_headers.blank?
    #
    #          @list_header = ListHeader.new
    #          @person = Person.new
    #          @p = Array.new
    #        else
    #          @list_header = @list_headers.first
    #          session[:current_list_id] = @list_header.id
    #          @person = @list_headers.first.people_on_list.first unless @list_headers.blank?
    #          session[:current_person_id] = @person.id
    #          @person = Person.new if @person.nil?
    #          @p = Array.new
    #          @p = @list_header.people_on_list
    #        end
    #      end
    #    end

    if request.post?
      @list_header = ListHeader.find(params[:list_header_id])
      params[:id] = params[:person_id] unless (params[:person_id].nil? || params[:person_id].empty?)
      c1 = Array.new
      c1 = @list_header.people_on_list
      @person = Person.find_by_id(params[:id].to_i)
      unless c1.include?(@person)
        @person = @list_header.people_on_list.first
      else
        @person
      end
      @p = Array.new
      @p = @list_header.people_on_list
      session[:current_list_id] = @list_header.id
      session[:current_person_id] = @person.id
    end

    #    @person = Person.new(:id => "") unless !@person.nil?
    @address = Address.new
    @phone = Phone.new
    @email = Email.new
    @fax = Fax.new
    @website = Website.new
    @masterdoc = MasterDoc.new
    @relationship = Relationship.new
    @employment = Employment.new
    @note = Note.new
    @image = @person.image unless (@person.nil? || @person.image.nil?)
    @role = Role.new
    @person_role = PersonRole.new
    respond_to do |format|
      format.html
    end
  end

  def create
    @person = Person.new(params[:person])
    @person.onrecord_since = Date.today()
    if @person.save
      if !params[:image].nil?
        @image = Image.new(params[:image])
        if @image.save
          @person.image = @image
        else
          flash[:warning] = "The image was not saved."
        end
      end

      # If the user wants to edit the record they just added
      if(params[:edit])
        flash[:message] = "Sucessfully added ##{@person.id} - #{@person.name}"
        redirect_to edit_person_path(@person)
        # If the user wants to continue adding records
      else
        flash[:message] = "Sucessfully added ##{@person.id} - #{@person.name} (<a href=#{edit_person_path(@person)}>edit details</a>)"
        redirect_to new_person_path
      end
    else
      @person.addresses.build(params[:person][:addresses_attributes][0]) if @person.addresses.empty?
      @person.phones.build(params[:person][:phones_attributes][0]) if @person.phones.empty?
      @person.emails.build(params[:person][:emails_attributes][0]) if @person.emails.empty?
      @person.faxes.build(params[:person][:faxes_attributes][0]) if @person.faxes.empty?
      @person.websites.build(params[:person][:websites_attributes][0]) if @person.websites.empty?

      flash[:warning] = "There was an error creating a new user profile. Please check you entered a family name."
      render :action =>'new'
    end
  end

  def update

    @person = Person.find(params[:id])
    Image.transaction do
      unless params[:image].nil?
        @image = Image.new(params[:image])
        if @image.save
          @person.image.destroy unless @person.image.nil?
          @person.image = @image
        else
          flash[:warning] = "The image was not saved. Please check that file was a valid image file."
        end
      end
    end

    @person.update_attributes(params[:person])
    flash[:warning] = "There was an error updating the person's details." unless @person.save
  

    flash[:message] = "#{@person.name}'s information was updated successfully." unless !flash[:warning].nil?
    if(params[:edit])
      redirect_to edit_person_path(@person)
    else
      redirect_to person_path(@person)
    end
  end

  def search
    if params[:person]
      @people = PeopleSearch.by_name(params[:person])
    elsif params[:phone]
      @people = PeopleSearch.by_phone(params[:phone])
    elsif params[:email]
      @people = PeopleSearch.by_email(params[:email])
    elsif params[:address]
      @people = PeopleSearch.by_address(params[:address])
    elsif params[:note]
      @people = PeopleSearch.by_note(params[:note])
    elsif params[:keyword]
      @people = PeopleSearch.by_keyword(params[:keyword])
    end
   
    @person = Person.new
    respond_to do |format|
      format.html
    end
  end

  def name_finder
    @person = Person.find(params[:person_id].to_i) rescue @person = Person.new
    @employment = Employment.find(params[:employment_id].to_i) rescue @employment = Employment.new
    #  reuse person.preferred_name to store update field name, if no update field, preferred_name is set to empty but will not be saved. Don't worry.
    @person.preferred_name = params[:update].nil?? nil : params[:update]
    
    
    respond_to do |format|
      format.js {  }
    end
  end

  def role_finder
    @person = Person.find(params[:person_id]) rescue @person = Person.new
    @person_role = PersonRole.find(params[:person_role_id]) rescue @person_role = PersonRole.new
    #  reuse person.preferred_name to store update field name, if no update field, preferred_name is set to empty but will not be saved. Don't worry.
    @person.preferred_name = params[:update].nil?? nil : params[:update]
    respond_to do |format|
      format.js {  }
    end
  end
  
  def find
    @person = Person.new
  end
  
  def name_card
    @person = Person.find(params[:id])
    respond_to do |format|
      format.js { }
    end
  end

  def master_doc_meta_type_finder
    @master_doc_meta_types = MasterDocMetaType.find(:all, :conditions => ["tag_meta_type_id = ?", params[:id]]) rescue @master_doc_meta_types = Array.new
    @masterdoc = MasterDoc.find(params[:master_doc_id]) rescue @masterdoc = MasterDoc.new
    respond_to do |format|
      format.js { }
    end
  end

  def master_doc_type_finder
    @master_doc_types = MasterDocType.find(:all, :conditions => ["tag_type_id = ?", params[:id]]) rescue @master_doc_types = Array.new
    @masterdoc = MasterDoc.find(params[:master_doc_id]) rescue @masterdoc = MasterDoc.new
    respond_to do |format|
      format.js { }
    end
  end
  def login_id_finder
    @person = Person.find(params[:person_id]) rescue @person = Person.new
    @login_account = LoginAccount.find(params[:login_account_id]) rescue @login_account = LoginAccount.new
    @primary_email = @person.primary_email.value unless @person.primary_email.blank?
    respond_to do |format|
      format.js()
    end

  end

#  def add_keywords
#    @person = Person.find(params[:id])
#
#    unless params[:add_keywords].nil?
#      params[:add_keywords].each do |keyword_id|
#        keyword = Keyword.find(keyword_id);
#        @person.keywords<<keyword
#      end
#    end
#    render "add_keywords.js"
#  end
#
#  def remove_keywords
#    @person = Person.find(params[:id])
#
#    unless params[:remove_keywords].nil?
#      params[:remove_keywords].each do |keyword_id|
#        keyword = Keyword.find(keyword_id)
#        @person.keywords.delete(keyword)
#      end
#    end
#    render "remove_keywords.js"
#  end


end
