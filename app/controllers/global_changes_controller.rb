class GlobalChangesController < ApplicationController


  # to show all the person lists and queries
  def index

    @list_headers = @current_user.all_person_lists
    @query_headers = PersonQueryHeader.saved_queries
    
    @table = ["Address","Keyword","Role","Group","Note"]

    respond_to do |format|
      format.html
    end
  end

  #to show the content in the first dropdown list
  def show_type
    if params[:select_type] == "addresses"

      @select_type=["Building Name","Town","State","Postal Code"]
    elsif params[:select_type] == "keyword"
      @select_type= KeywordType.active_keyword_type

    elsif params[:select_type] == "role"
      @select_type= RoleType.active_role_type
    elsif params[:select_type] == "group"
      @select_type = TagType.show_meta_type
    elsif params[:select_type] == "note"
      @select_type = NoteType.active_note_type
    end
    @result = params[:select_type]
    respond_to do |format|
      format.js
    end
  end

  def change_value
    if params[:source_id].include?("list")
      @source = PersonListHeader.find(params[:source_id].gsub("_list","").to_i) rescue @source = PrimaryList.find(params[:source_id].gsub("_list","").to_i)
      @source_value = @source.entity_on_list
    elsif params[:source_id].include?("query")
      @source = PersonQueryHeader.find(params[:source_id].gsub("_query","").to_i) 
      @source_value = @source.run
    end
   
 
    if params[:type] == "Change"

      @source_value.each do |i|
        if params[:table_name]=="addresses"
          type=TableMetaType.find(:first, :conditions => ["name = ? AND tag_meta_type_id = ?", params[:table_field], TableMetaMetaType.find_by_name(params[:table_name])]).category

          unless i.__send__(params[:table_name]).empty?
            entity = i.__send__(params[:table_name]).first
            if type.include?("FK")

              change_forieng_key = (params[:table_field]).camelize.constantize.find_by_name(params[:select_data])

              entity.__send__(params[:table_field].to_s.foreign_key+"=" , change_forieng_key.id)
            else        
              entity.__send__((params[:table_field]+"=").to_sym, params[:change_value])  

              entity.save!
            end

          end

  
        end
      end

    elsif params[:type] == "Delete"
      @source_value.each do |i|
        if params[:table_name]=="addresses"
          unless i.__send__(params[:table_name]).empty?

            entity = i.__send__(params[:table_name]).first

            entity.__send__((params[:table_field]+"=").to_sym, "")

            entity.save!

          end
        elsif params[:table_name]=="keyword"

          @person_keyword = KeywordLink.find_keyword(i.id,params[:select_data].to_i)
     
          unless @person_keyword.nil?
            @person_keyword.destroy
          end
          
        elsif params[:table_name]=="role"
          @person_role = PersonRole.find_person_role(i.id,params[:select_data].to_i)
           
          
          unless @person_role.nil?
            @person_role.destroy
          end
        elsif params[:table_name] == "group"
          @person_group = PersonGroup.find_person_group(i.id,params[:select_data].to_i)
      
          unless @person_group.nil?
            @person_group.destroy
          end
        elsif params[:table_name] == "note"
          @person_note = Note.find_person_note(i.id,params[:table_field].to_i)
          
          unless @person_note.nil?
            @person_note.destroy
          end
        end
      end

    elsif params[:type] == "Add"

      @source_value.each do |i|
        if params[:table_name] == "addresses"
          
          unless i.__send__(params[:table_name]).empty?

            entity = i.__send__(params[:table_name]).first
            if params[:add_front] == "true"
              entity.__send__((params[:table_field]+"=").to_sym, params[:change_value]+entity.__send__(params[:table_field]))

            end
            
            if params[:add_end] == "true"
              entity.__send__((params[:table_field]+"=").to_sym, entity.__send__(params[:table_field])+params[:change_value])
            end

            entity.save!

          end

        elsif params[:table_name] == "keyword"
          @person_keyword = KeywordLink.find_all_person_keyword(i.id,params[:select_data].to_i)
          
        
          if @person_keyword.empty?
            new_keyword_link = KeywordLink.new
            new_keyword_link.keyword_id = params[:select_data].to_i
            new_keyword_link.taggable_id = i.id
            new_keyword_link.taggable_type = "Person"
            new_keyword_link.save!
          end
        elsif params[:table_name] == "role"
          @person_role = PersonRole.find_all_person_role(i.id,params[:select_data].to_i)

          if @person_role.empty?
            new_person_role = PersonRole.new
            new_person_role.role_id = params[:select_data].to_i
            new_person_role.person_id = i.id
     
            new_person_role.assigned_by = @current_user.id
            new_person_role.start_date = Time.now.strftime("%Y-%m-%d")
            new_person_role.save!
          end
        elsif params[:table_name] == "group"
          @person_group = PersonGroup.find_all_person_group(i.id,params[:select_data].to_i)

          if @person_group.empty?
            new_person_group = PersonGroup.new
            new_person_group.tag_id = params[:select_data].to_i
            new_person_group.people_id = i.id
            new_person_group.save!
          end
        elsif params[:table_name]=="note"
          @person_note = Note.find_all_person_note(i.id,params[:change_value],params[:table_field].to_i)
          
          if @person_note.empty?
            new_person_note = Note.new
            new_person_note.noteable_id = i.id
            new_person_note.label = params[:change_value]
            new_person_note.noteable_type = "Person"
            new_person_note.note_type_id = params[:table_field].to_i
            new_person_note.active = true
            new_person_note.save!
          end
        end
      end

    end

    respond_to do |format|
      format.js
    end
    
  end


  def check_field_type


    if params[:table_name] == "keyword"
      @value = KeywordType.find(params[:table_field].to_i).keywords
    elsif params[:table_name] == "role"
      @value =  RoleType.find(params[:table_field].to_i).roles
    elsif params[:table_name] == "group"
      @value=GroupMetaType.find(params[:table_field].to_i).group_types
    end

    @type =params[:table_name]
    respond_to do |format|
      format.js
    end
  end
end
