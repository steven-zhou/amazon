class GlobalChangesController < ApplicationController


  # to show all the person lists and queries
  def index

    @list_headers = @current_user.all_person_lists
    @query_headers = PersonQueryHeader.saved_queries
    
    @table = ["Address","Keyword","Group","Note"]

    respond_to do |format|
      format.html
    end
  end

  def page_initial
    @render_page = params[:render_page]
    @field = params[:field]
    if @field == "person_part"
         @list_headers = @current_user.all_person_lists
    @query_headers = PersonQueryHeader.saved_queries
    else
     @list_headers = @current_user.all_group_organisation_lists
   @query_headers  = OrganisationQueryHeader.saved_queries
    end
    respond_to do |format|
      format.js
    end
  end




  def org_index
   @list_headers = @current_user.all_group_organisation_lists
   @query_headers  = OrganisationQueryHeader.saved_queries
    respond_to do |format|
      format.html
    end
  end

  #to show the content in the first dropdown list
  def show_type
    @type = params[:type]
    if params[:select_type] == "addresses"

      @select_type=["Building Name","Town","State","Postal Code"]
    elsif params[:select_type] == "keyword"
      @select_type= KeywordType.active_keyword_type

#    elsif params[:select_type] == "role"
#      @select_type= RoleType.active_role_type
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
    if params[:source_type] == "Person"
    if params[:source_id].include?("list")
      @source = PersonListHeader.find(params[:source_id].gsub("_list","").to_i) rescue @source = PrimaryList.find(params[:source_id].gsub("_list","").to_i)
      @source_value = @source.entity_on_list
    elsif params[:source_id].include?("query")
      @source = PersonQueryHeader.find(params[:source_id].gsub("_query","").to_i) 
      @source_value = @source.run
    end
    elsif params[:source_type] == "Organisation"

      if params[:source_id].include?("list")
      @source = OrganisationListHeader.find(params[:source_id].gsub("_list","").to_i) rescue @source = OrganisationPrimaryList.find(params[:source_id].gsub("_list","").to_i)
      @source_value = @source.entity_on_list
    elsif params[:source_id].include?("query")
      @source = OrganisationQueryHeader.find(params[:source_id].gsub("_query","").to_i)
      @source_value = @source.run
    end
      
    end


   
 
    if params[:type] == "Change"

      @source_value.each do |i|
        if params[:table_name]=="addresses"
          unless i.__send__(params[:table_name]).empty?
            entity = i.__send__(params[:table_name]).first

              entity.__send__((params[:table_field]+"=").to_sym, params[:change_value])  


         unless entity.save!
           flash.now[:error]= "Please Check Your Input"

           end
          end

  
        end
      end

    elsif params[:type] == "Delete"
      source_type = params[:source_type]
      @source_value.each do |i|
        if params[:table_name]=="addresses"
          unless i.__send__(params[:table_name]).empty?

            entity = i.__send__(params[:table_name]).first

            entity.__send__((params[:table_field]+"=").to_sym, "")

          unless  entity.save!
            flash.now[:error]= "Please Check Your Input"
          end

          end
        elsif params[:table_name]=="keyword"

          @person_keyword = KeywordLink.find_keyword(i.id,params[:select_data].to_i,source_type)
     
          unless @person_keyword.nil?
            @person_keyword.destroy
          else
          flash.now[:error]= "Please Check Your Input"
          end

        elsif params[:table_name] == "group"

          if source_type == "Person"
          @group = PersonGroup.find_person_group(i.id,params[:select_data].to_i)
          elsif source_type == "Organisation"
            @group = OrganisationGroup.find_org_group(i.id,params[:select_data].to_i)
           else
          flash.now[:error]= "Please Check Your Input"
          end
    
          unless @group.nil?
            @group.destroy
          end
        elsif params[:table_name] == "note"
          if source_type == "Person"
          @note = Note.find_person_note(i.id,params[:table_field].to_i,params[:change_value])
            elsif source_type == "Organisation"
              @note = Note.find_org_note(i.id,params[:table_field].to_i,params[:change_value])
          end
          
          unless @note.nil?
            @note.destroy
          end
        end
      end

    elsif params[:type] == "Add"
      source_type = params[:source_type]
      @source_value.each do |i|
        if params[:table_name] == "addresses"

          unless i.__send__(params[:table_name]).empty?

            entity = i.__send__(params[:table_name]).first
            entity_one = entity.__send__(params[:table_field])
            if params[:add_front] == "true"

              entity.__send__((params[:table_field]+"=").to_sym, params[:change_value]+entity_one)
            end
            
            if params[:add_end] == "true"
              entity.__send__((params[:table_field]+"=").to_sym, entity.__send__(params[:table_field])+params[:change_value])
            end

            unless (params[:add_front] == "true" || params[:add_end] == "true")
             flash.now[:error]= "Please Select the Checkbox"
            end

          unless  entity.save!
              flash.now[:error]= "Please Check Your Input"
          end

          end

        elsif params[:table_name] == "keyword"
          @keyword = KeywordLink.find_all_keyword(i.id,params[:select_data].to_i,source_type)
          
        
          if @keyword.empty?
            new_keyword_link = KeywordLink.new
            new_keyword_link.keyword_id = params[:select_data].to_i
            new_keyword_link.taggable_id = i.id
            new_keyword_link.taggable_type = source_type
           unless new_keyword_link.save!
             flash.now[:error]= "Please Check Your Input"
          end
          end

        elsif params[:table_name] == "group"
          if source_type == "Person"
          @person_group = PersonGroup.find_all_person_group(i.id,params[:select_data].to_i)

          if @person_group.empty?
            new_person_group = PersonGroup.new
            new_person_group.tag_id = params[:select_data].to_i
            new_person_group.people_id = i.id
           unless new_person_group.save!
                   flash.now[:error]= "Please Check Your Input"
          end
          end

          elsif source_type =="Organisation"
            @org_group = OrganisationGroup.find_all_org_group(i.id,params[:select_data].to_i )
            if @org_group.empty?
              new_org_group = OrganisationGroup.new
            new_org_group.tag_id = params[:select_data].to_i
            new_org_group.organisation_id = i.id
           unless new_org_group.save!
                   flash.now[:error]= "Please Check Your Input"
          end

          end
          end
        elsif params[:table_name]=="note"

          @note = Note.find_all_note(i.id,params[:change_value],params[:table_field].to_i,source_type)
          
          if @note.empty?
            new_note = Note.new
            new_note.noteable_id = i.id
            new_note.label = params[:change_value]
            new_note.noteable_type = source_type
            new_note.note_type_id = params[:table_field].to_i
            new_note.active = true
           unless new_note.save!
             flash.now[:error]= "Please Check Your Input"
          end
          end
        end
      end

    end

    respond_to do |format|
      format.js
    end
    
  end


  def check_field_type
      @source_type = params[:type]
      @add_delete = ["Add","Delete"]
      @add_change_delete = ["Add","Change","Delete"]
    if params[:table_name] == "keyword"
      @value = KeywordType.find(params[:table_field].to_i).keywords
#    elsif params[:table_name] == "role"
#      @value =  RoleType.find(params[:table_field].to_i).roles
    elsif params[:table_name] == "group"
      @value=GroupMetaType.find(params[:table_field].to_i).group_types
    end

    @type =params[:table_name]
    respond_to do |format|
      format.js
    end
  end
end
