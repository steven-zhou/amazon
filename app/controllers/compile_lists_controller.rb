class CompileListsController < ApplicationController

  def clear
    @compile_lists = CompileList.find_all_by_login_account_id(params[:login_account_id])
    @compile_lists.each do |i|
      i.destroy
    end
    respond_to do |format|
      format.js
    end
  end

  def compile
    
    @include_lists = CompileList.find_all_by_login_account_id(params[:login_account_id])
    @allow_duplication = params[:allow_duplication]
    top = params[:top]
    if(top == "number")
      value = params[:top_number].to_i
    else
      value = params[:top_percent].to_i
    end

    unless @include_lists.empty?

      @exclude_lists = ExcludeList.find_all_by_login_account_id(params[:login_account_id])
      include_ids = Array.new
      exclude_ids = Array.new
      person_ids = Array.new

      @include_lists.each do |i|
        @list_header = ListHeader.find(i.list_header_id)
        @list_details = @list_header.list_details
        @list_details.each do |list_detail|
          include_ids << list_detail.person_id
        end
      end

      @exclude_lists.each do |i|
        @list_header = ListHeader.find(i.list_header_id)
        @list_details = @list_header.list_details
        @list_details.each do |list_detail|
          exclude_ids << list_detail.person_id
        end
      end

      person_ids = include_ids - exclude_ids
      person_ids = person_ids.uniq if (@allow_duplication=="false")

      if(value>0)
        if(top == "number")
          person_ids = person_ids[0, value]
        else
          person_ids = person_ids[0, value*person_ids.size/100]
        end
      end

      @people = Array.new
      puts "#{person_ids.size}"
      person_ids.each do |i|
        @person = Person.find(i)
        @people << @person
      end

      #clear list compile temp table, and save result to temp table
      ListCompileGrid.find_all_by_login_account_id(session[:user]).each do |i|
        i.destroy
      end

      @people.each do |person|
        @lcg = ListCompileGrid.new
        @lcg.login_account_id = session[:user]
        @lcg.grid_object_id = person.id
        @lcg.field_1 = person.first_name
        @lcg.field_2 = person.family_name
        @lcg.save
      end

      @list_header = ListHeader.new

    else#Include list is empty
      @people = Array.new
      flash.now[:error] = flash_message(:message => "Include list is empty")
    end

    respond_to do |format|
      format.js
    end
  end
end
