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
      @people = Array.new
      person_ids.each do |i|
        @person = Person.find(i)
        @people << @person
      end

      puts "^^^ #{@people.size} EOD"

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
