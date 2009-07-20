class PeopleController < ApplicationController
  
  include PeopleSearch

  def new
    @person = Person.new
    @person.addresses.build
    @person.phones.build
    @person.emails.build
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
    @primary_address = @person.primary_address
    @other_phones = @person.other_phones
    @other_emails = @person.other_emails
    @other_addresses = @person.other_address
    respond_to do |format|
      format.html
    end
  end
  
  def edit
    @person = Person.find(params[:id])
    @address = Address.new
    @phone = Phone.new
    @email = Email.new
    @masterdoc = MasterDoc.new
    @relationship = Relationship.new
    @note = Note.new

    respond_to do |format|
      format.html
    end
  end

  def create
    @person = Person.new(params[:person])
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

      flash[:warning] = "Error in saving person"
      render :action =>'new'
    end
  end

  def update
    @person = Person.find(params[:id])
    @person.update_attributes(params[:person])
    @person.save!
    #---------------------james part---------------down
    #if params[:submit] == "edit_details"
    # render 'edit_details.js'
    #elsif params[:submit] == "edit_names"
    #  render 'edit_names.js'
    #else
    #  render :nothing => true
    #end
    #---------------------james part---------------up
    flash[:message] = "#{@person.name}'s information have been updated"
    redirect_to person_path(@person)
  end

  def search
    if params[:person]
      @people = PeopleSearch.by_name(params[:person])
    elsif params[:phone]
      @people = PeopleSearch.by_phone(params[:phone])
    elsif params[:email]
      @people = PeopleSearch.by_email(params[:email][:contact_type_id], params[:email][:value])
    elsif params[:address]
      @people = PeopleSearch.by_address(params[:address])
    elsif params[:note]
      @people = PeopleSearch.by_note(params[:note])
    elsif params[:keyword]
      puts "keyword search"
      @people = PeopleSearch.by_keyword(params[:keyword])
    end
    puts " ***** DEBUG #{@people.class}"

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
