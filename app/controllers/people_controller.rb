class PeopleController < ApplicationController
  
  include PeopleSearch

  skip_before_filter :verify_authenticity_token, :only => [:show, :edit]
  protect_from_forgery :except => [:post_data]
  
  def new
   
    @person = Person.new
    @person.addresses.build
    @person.phones.build
    @person.faxes.build
    @person.emails.build
    @person.websites.build
    @image = Image.new
    @postcodes = DomesticPostcode.find(:all)
   
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
    @list_headers = @current_user.list_headers

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
          #@person = @list_headers.first.people_on_list.first unless @list_headers.blank?
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

    # redirect_to "show.html"
     
  end

  
  def edit
    @postcodes = DomesticPostcode.find(:all)
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
    @person_group = PersonGroup.new


    #    if params[:show_list]
    #    session[:show_list] = params[:show_list]
    #    @person = Person.find(params[:id]) rescue @person = Person.find(session[:current_person_id])
    #
    #      render 'show_list.html'
    #
    #    else
    

    respond_to do |format|
      format.html
   
    end



    #    end

 
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
      @person.websites.build(params[:person][:websites_attributes][0]) if @person.websites.empty?
      @postcodes = DomesticPostcode.find(:all)
      flash.now[:warning] = "There was an error creating a new user profile. Please check you entered a family name."
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
    @person = Person.new
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

    #clear temple table and save result into temple table
    PeopleSearchGrid.find_all_by_login_account_id(session[:user]).each do |i|
      i.destroy
    end

    @people.each do |person|
      @psg = PeopleSearchGrid.new
      @psg.login_account_id = session[:user]
      @psg.grid_object_id = person.id
      @psg.field_1 = person.first_name
      @psg.field_2 = person.family_name
      @psg.field_3 = person.primary_address.first_line unless person.primary_address.blank?
      @psg.field_4 = person.primary_phone.value unless person.primary_phone.blank?
      @psg.field_5 = person.primary_email.address unless person.primary_email.blank?
      @psg.save
    end
    
    respond_to do |format|
      format.html
    end
  end

  def test_search
    @person = Person.new
    people = Person.find(:all, :order => "id") do
      if params[:_search] == "true"
        first_name =~ "%#{params[:first_name]}%" if params[:first_name].present?
        family_name  =~ "%#{params[:family_name]}%" if params[:family_name].present?
      end
      paginate :page => params[:page], :per_page => params[:rows]
      order_by "#{params[:sidx]} #{params[:sord]}"
    end
    if request.xhr?
      render :json => people.to_jqgrid_json([:id,:first_name,:family_name], params[:page], params[:rows], people.total_entries) and return
    end
  end

  def flexi_search
    @person = Person.new
    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "id"
    end

    if (!sortorder)
      sortorder = "asc"
    end

    if (!page)
      page = 1
    end

    if (!rp)
      rp = 10
    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @countries = Person.find(:all,
  	:order => sortname+' '+sortorder,
  	:limit =>rp,
  	:offset =>start
  	)
      count = Person.count(:all)
    end

    # User provided search terms
    if(query != "%%")
        @countries = Person.find(:all,
	  :order => sortname+' '+sortorder,
	  :limit =>rp,
  	  :offset =>start,
  	  :conditions=>[qtype +" like ?", query])
	count = Person.count(:all,
	  :conditions=>[qtype +" like ?", query])
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count

    return_data[:rows] = @countries.collect{|u| {
  			   :cell=>[u.id,
  			   u.first_name,
  			   u.family_name]}}

    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
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

 

  def show_list

    @person = Person.find(params[:person_id]) rescue @person = Person.find(session[:current_person_id])
    @list_header = ListHeader.find(session[:current_list_id])
    @p = Array.new
    @p = @list_header.people_on_list
    @current_operation = params[:current_operation]
    respond_to do |format|
      format.js
    end
  end


  def show_left
  
 
    @group_types = LoginAccount.find(session[:user]).group_types
    @list_headers = Array.new
    c = Array.new
    @group_types.each do |group_type|
      a = group_type.list_headers
      c += a
      @list_headers = c.uniq
    end

    @person = Person.find(params[:person_id]) rescue @person = Person.find(session[:current_person_id])
    @list_header = ListHeader.find(session[:current_list_id])
    @p = Array.new
    @p = @list_header.people_on_list
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
    session[:select_list_person] = params[:person_id]
#   session[:current_person_id]=params[:person_id]

    if(params[:current_operation] == "edit_list")
      render 'show_edit_left.js'

    else

      respond_to do |format|
        format.js
      end
    end


  end






  def search_lists

    #    # @name_search = Person.find(:all, :conditions => ["first_name ILIKE ? AND family_name ILIKE ?", "%#{params[:name]}%", "%#{params[:name]}%"])
    #    @search_list_result = Array.new
    #
    #    params[:person_first_name] = Hash.new
    #    params[:person_family_name] = Hash.new
    #    #  params[:phone_contact] = Hash.new
    #    #  params[:email_contact] = Hash.new
    #    params[:person_first_name][:first_name] = params[:name]
    #    params[:person_family_name][:family_name] = params[:name]
    #    #  params[:phone_contact][:phone_pre_value] = params[:phone]
    #    #  params[:phone_contact][:phone_value] = params[:phone]
    #    #  params[:phone_contact][:phone_post_value] = params[:phone]
    #    #  params[:email_contact][:email_address] = params[:email]
    #
    #    @search_list_result  = PeopleSearch.by_name(params[:person_first_name])
    #    @search_list_result  += PeopleSearch.by_name(params[:person_family_name])
    #    #  @phone_search = PeopleSearch.by_phone(params[:phone_contact])
    #    #  @email_search = PeopleSearch.by_email(params[:email_contact])
    #    #  @search_list_result << @name_search
    #    #  @search_list_result << @email_search
    #    #  @search_list_result << @phone_search
    #
    #    @search_list_result.uniq
    #   puts "********#{@search_list_result.to_yaml}********"


 

    @name_search=params[:name]
    @email_search=params[:email]
    @phone_search=params[:phone]
    @list_people_id = session[:current_list_id]
    @list_people = ListHeader.find(session[:current_list_id]).people_on_list
    @search_list_result=@list_people.find(:all)
    #    if (@name_search!="")
    #   @search_list_result = @list_people.find(:all,:include => [:contacts], :conditions => ["people.first_name LIKE ? OR people.family_name LIKE ?", "%#{@name_search}%", "%#{@name_search}%"])
    #    end
    #    if (@email_search!="")
    @search_list_result = @list_people.find(:all,:include => [:contacts], :conditions => ["contacts.value LIKE ?","%#{@email_search}%"])
    #    @search_list_result = @search_list_result.find(:all,:include => [:contacts], :conditions => ["contacts.value LIKE ? AND contacts.type = 'Phone'","%#{@phone_search}%"])
    #    end
    respond_to do |format|
      format.js
    end
  end


end
