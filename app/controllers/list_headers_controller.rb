class ListHeadersController < ApplicationController
  # Added System Logging

  def new
    respond_to do |format|
      format.html
    end
  end

  def create
    if(params[:compile]) #Compile List
      @lcg = ListCompileGrid.find_all_by_login_account_id(session[:user])
      if(@lcg.size > 0)

        @list_header = ListHeader.new(params[:list_header])
        @list_header.last_date_generated = Date.today()
        @list_header.list_size = 0
        @list_header.source_type = "C" #generate from list compile
        @include_lists = IncludeList.find_all_by_login_account_id(session[:user])
        @exclude_lists = ExcludeList.find_all_by_login_account_id(session[:user])
        include_lists = Array.new
        exclude_lists = Array.new
        @include_lists.each do |i|
          include_lists << i.list_header.name
        end
        @exclude_lists.each do |i|
          exclude_lists << i.list_header.name
        end
        @list_header.source = "Compile from List - Include(#{include_lists.join(', ')})"
        @list_header.source += " And Exclude(#{exclude_lists.join(', ')})" unless @exclude_lists.empty?
        @list_header.status = true

        ListHeader.transaction do
          if @list_header.save
            system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new List Header with ID #{@list_header.id}.")
            @lcg.each do |i|
              @list_detail = ListDetail.new(:list_header_id => @list_header.id, :person_id => i.grid_object_id)
              @list_detail.save
            end
            #assign new saved list to group or user
            assign_group_or_user
            flash.now[:message] = flash_message(:type => "object_created_successfully", :object => "list")
          else
            flash.now[:error] = flash_message(:type => "field_missing", :field => "name") if (!@list_header.errors.on(:name).nil? && @list_header.errors.on(:name).include?("can't be blank"))
            flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "name") if (!@list_header.errors.on(:name).nil? && @list_header.errors.on(:name).include?("has already been taken"))
          end
        end
        

      else
        flash.now[:error] = flash_message(:message => "list can't be empty")
      end


    else

      if(params[:copy_source_id]) #copy
        @list_header_old = ListHeader.find(params[:copy_source_id].to_i)
        @list_header = @list_header_old.class.new(params[:list_header])
        @list_header.allow_duplication = @list_header_old.allow_duplication
        @list_header.list_size = 0
        @list_header.source_type = "L" #copy from list
        @list_header.source = "Copy from List - #{@list_header_old.name}"
        @list_header.status = true
        @list_header.last_date_generated = Date.today()

        if @list_header.save
          ListHeader.transaction do
            @list_header_old.list_details.each do |i|
              @list_detail = ListDetail.new(:list_header_id => @list_header.id, :person_id => i.person_id)
              @list_detail.save
            end
          end
          #assign new saved list to group or user
          assign_group_or_user
          flash.now[:message] = flash_message(:type => "object_created_successfully", :object => "list (copy)")
        else
          flash.now[:error] = flash_message(:type => "field_missing", :field => "name") if (!@list_header.errors.on(:name).nil? && @list_header.errors.on(:name).include?("can't be blank"))
          flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "name") if (!@list_header.errors.on(:name).nil? && @list_header.errors.on(:name).include?("has already been taken"))
        end


      else #create
        @qrg = QueryResultGrid.find_all_by_login_account_id(session[:user])
        if(@qrg.size > 0)
          @query_header = QueryHeader.find(params[:query_header_id].to_i)
          @list_header = ListHeader.new(params[:list_header])
          @list_header.last_date_generated = Date.today()
          @list_header.list_size = 0
          @list_header.source_type = "Q" #generate from query
          @list_header.source = "Generate by Query - #{@query_header.group == "save" ? @query_header.name : 'Temp Query'}"
          @list_header.status = true

          ListHeader.transaction do
            if @list_header.save
              @user_list=UserList.new   # save to the user lists table
              @user_list.user_id = session[:user]
              @user_list.list_header_id = @list_header.id
              @user_list.save
              @qrg.each do |i|
                @list_detail = ListDetail.new(:list_header_id => @list_header.id, :person_id => i.grid_object_id)
                @list_detail.save
              end
              #assign new saved list to group or user
              assign_group_or_user
              flash.now[:message] = flash_message(:type => "object_created_successfully", :object => "list")
            else
              flash.now[:error] = flash_message(:type => "field_missing", :field => "name") if (!@list_header.errors.on(:name).nil? && @list_header.errors.on(:name).include?("can't be blank"))
              flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "name") if (!@list_header.errors.on(:name).nil? && @list_header.errors.on(:name).include?("has already been taken"))
            end
          end
        else
          flash.now[:error] = flash_message(:message => "list can't be empty")
        end
      end
    end
    @lists = @current_user.all_person_lists
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @list_header = ListHeader.find(params[:id].to_i)
    @list_header.destroy
    @lists = @current_user.all_person_lists
    respond_to do |format|
      format.js
    end
  end

  def edit
    @list_header = ListHeader.find(params[:id].to_i)
    @list_details = @list_header.list_details
    @entities = @list_header.entity_on_list

    #clear list edit temp table, and save result to temp table
    ListEditGrid.find_all_by_login_account_id(session[:user]).each do |i|
      i.destroy
    end

    if @list_header.class.to_s == "PersonListHeader"
      create_person_list_edit_grid
      @entity = "person"
    else
      create_organisation_list_edit_grid
      @entity = "organisation"
    end
    respond_to do |format|
      format.js
    end
  end

  def update
    @list_header = ListHeader.find(params[:id].to_i)
    if  @list_header.update_attributes(params[:list_header])

      @list_header = ListHeader.find(@list_header)
      if !@list_header.allow_duplication  # if allow_duplication is change to be false

        if @list_header.class.to_s == "PersonListHeader"
          update_person_list_update_grid
          @entity = "person"
        else
          update_organisation_list_update_grid
          @entity = "organisation"
        end
        
      end
      flash.now[:message] = flash_message(:type => "object_updated_successfully", :object => "list")
    else
      flash.now[:error]= "The List Name Already Exists. This Field Must be Unique, Please Try Again."
    end
    @list_header = ListHeader.find(@list_header)
    @lists = @entity=="person" ? @current_user.all_person_lists : @current_user.all_organisation_lists
    respond_to do |format|
      format.js
    end
  end

  def copy
    @list_header = ListHeader.find(params[:id].to_i)
    respond_to do |format|
      format.js
    end
  end

  def delete_details
    @list_header = ListHeader.find(params[:id].to_i)
    params[:list_detail].each do |i|
      @list_detail = ListDetail.find(i.to_i)
      @list_detail.destroy
    end
    @list_header.source = @list_header.source.nil? ? "Updated" : @list_header.source.chomp(" & Updated") + " & Updated"
    @list_header.save
    respond_to do |format|
      format.js
    end
  end

  def manage_list
    @list_headers = @current_user.all_person_lists
    respond_to do |format|
      format.html
    end
  end

  def compile_list
    @list_headers = @current_user.all_person_lists
    @compile_lists = CompileList.find_all_by_login_account_id(session[:user])
    @compile_lists.each do |i|
      i.destroy
    end
    respond_to do |format|
      format.html
    end
  end

  def org_manage_list
    @lists = @current_user.all_organisation_lists
    respond_to do |format|
      format.html
    end
  end


  def org_compile_list
    @lists = @current_user.all_organisation_lists
    @compile_lists = CompileList.find_all_by_login_account_id(session[:user])
    @compile_lists.each do |i|
      i.destroy
    end
    respond_to do |format|
      format.html
    end
  end

  private
  def assign_group_or_user
    if LoginAccount.find(session[:user]).class.to_s == "SystemUser"
      @user_list=UserList.new
      @user_list.user_id = session[:user]
      @user_list.list_header_id = @list_header.id
      @user_list.save
    else
      @group_list=GroupList.new
      @group_list.tag_id = GroupType.find_by_name("Power User").id
      @group_list.list_header_id = @list_header.id
      @group_list.save
    end
  end

  def create_person_list_edit_grid
    @entities.each do |person|
      @leg = ListEditGrid.new
      @leg.login_account_id = session[:user]
      @leg.grid_object_id = person.id
      @leg.field_1 = person.first_name
      @leg.field_2 = person.family_name
      @leg.save
    end
  end

  def create_organisation_list_edit_grid
    @entities.each do |organisation|
      @leg = ListEditGrid.new
      @leg.login_account_id = session[:user]
      @leg.grid_object_id = organisation.id
      @leg.field_1 = organisation.full_name
      @leg.field_2 = organisation.trading_as
      @leg.save
    end
  end

  def update_person_list_update_grid
    delete_list = Array.new
    person_list = Array.new
    @list_header.list_details.each do |i|
      if person_list.include?(i.entity_id)
        delete_list.push(i)
      else
        person_list.push(i.entity_id)
      end
    end

    delete_list.each do |i|
      i.destroy
    end

    @people = @list_header.entity_on_list

    #clear list edit temp table, and save result to temp table
    ListEditGrid.find_all_by_login_account_id(session[:user]).each do |i|
      i.destroy
    end

    @people.each do |person|
      @leg = ListEditGrid.new
      @leg.login_account_id = session[:user]
      @leg.grid_object_id = person.id
      @leg.field_1 = person.first_name
      @leg.field_2 = person.family_name
      @leg.save
    end
  end

  def update_organisation_list_update_grid
    delete_list = Array.new
    organisation_list = Array.new
    @list_header.list_details.each do |i|
      if organisation_list.include?(i.entity_id)
        delete_list.push(i)
      else
        organisation_list.push(i.entity_id)
      end
    end

    delete_list.each do |i|
      i.destroy
    end

    @organisation = @list_header.entity_on_list

    #clear list edit temp table, and save result to temp table
    ListEditGrid.find_all_by_login_account_id(session[:user]).each do |i|
      i.destroy
    end

    @organisation.each do |organisation|
      @leg = ListEditGrid.new
      @leg.login_account_id = session[:user]
      @leg.grid_object_id = organisation.id
      @leg.field_1 = organisation.full_name
      @leg.field_2 = organisation.trading_as
      @leg.save
    end
  end
end
