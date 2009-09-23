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
    params[:id] = params[:person_id] unless (params[:person_id].nil? || params[:person_id].empty?)
    @person = Person.find_by_id(params[:id].to_i)
    @person = Person.new if @person.nil?
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
    params[:id] = params[:person_id] unless (params[:person_id].nil? || params[:person_id].empty?)
    @person = Person.find_by_id(params[:id].to_i)
    @person = Person.new(:id => "") unless !@person.nil?
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

  def add_keywords
    @person = Person.find(params[:id])

    unless params[:add_keywords].nil?
      params[:add_keywords].each do |keyword_id|
        keyword = Keyword.find(keyword_id);
        @person.keywords<<keyword
      end
    end
    render "add_keywords.js"
  end

  def remove_keywords
    @person = Person.find(params[:id])

    unless params[:remove_keywords].nil?
      params[:remove_keywords].each do |keyword_id|
        keyword = Keyword.find(keyword_id)
        @person.keywords.delete(keyword)
      end
    end
    render "remove_keywords.js"
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
    respond_to do |format|
      format.js()
    end

  end

end
