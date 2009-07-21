class PeopleController < ApplicationController
  
  include PeopleSearch

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
    @person = Person.find_by_id(params[:id])
    @person = Person.new if @person.nil?
    @primary_phone = @person.primary_phone
    @primary_email = @person.primary_email
    @primary_fax = @person.primary_fax
    @primary_website = @person.primary_website
    @primary_address = @person.primary_address
    @other_phones = @person.other_phones
    @other_emails = @person.other_emails
    @other_faxes = @person.other_faxes
    @other_websites = @person.other_websites
    @other_addresses = @person.other_address
    @notes = @person.notes 
    respond_to do |format|
      format.html
    end
  end
  
  def edit
    @person = Person.find(params[:id])
    @address = Address.new
    @phone = Phone.new
    @email = Email.new
    @fax = Fax.new
    @website = Website.new
    @masterdoc = MasterDoc.new
    @relationship = Relationship.new
    @note = Note.new
    @image = @person.image unless @person.image.nil?

    respond_to do |format|
      format.html
    end
  end

  def create
    if !params[:image].nil?
      @image = Image.new(params[:image])
      @image.save
      @person = Person.new(params[:person])
      @person.image = @image
    else
      @person = Person.new(params[:person])
    end
    if @person.save
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

      flash[:warning] = "Error in saving person"
      render :action =>'new'
    end
  end

  def update
    Person.transaction do
      @person = Person.find(params[:id])

      if !params[:image].nil?
        @image = Image.new(params[:image])
        flash[:warning] = "The image was not saved." unless @image.save
        @person.image.destroy unless @person.image.nil?
        @person.image = @image
      end

      @person.update_attributes(params[:person])
      @person.save!
    end

    flash[:message] = "#{@person.name}'s information have been updated" unless !flash[:warning].nil?
    redirect_to person_path(@person)
  end

  def search
    if params[:person]
      @people = PeopleSearch.by_name(params[:person])
    elsif params[:phone]
      @people = PeopleSearch.by_phone(params[:phone][:contact_type_id], params[:phone][:pre_value],params[:phone][:value], params[:phone][:post_value])
    elsif params[:email]
      @people = PeopleSearch.by_email(params[:email][:contact_type_id], params[:email][:value])
    elsif params[:address]
      @people = PeopleSearch.by_address(params[:address])
    elsif params[:note]
      @people = PeopleSearch.by_note(params[:note][:note_type_id], params[:note][:label],params[:note][:short_description])
    elsif params[:keyword]
      puts "keyword search"
      @people = PeopleSearch.by_keyword(params[:keyword][:id])
    end
   

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
    @person = Person.find(params[:person_id]) rescue @person = nil

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
end
