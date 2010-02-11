class GlobalChangesController < ApplicationController

  def index
    @list_headers = @current_user.all_person_lists
    @table = ["Address","Keyword","Role","Group","Note"]
    respond_to do |format|
      format.html
    end
  end
  
  def show_type
    if params[:select_type] == "addresses"

        @select_type=["Building Name","Town","State","Postal Code"]
      elsif params[:select_type] == "keyword"

        elsif params[:select_type] == "role"

          elsif params[:select_type] == "group"

            elsif params[:select_type] == "note"

    end
      @result = params[:select_type] 
    respond_to do |format|
      format.js
    end
  end

  def change_value


    @source = PersonListHeader.find(params[:source_id].to_i) rescue @source = PrimaryList.find(params[:source_id].to_i)
    type=TableMetaType.find(:first, :conditions => ["name = ? AND tag_meta_type_id = ?", params[:table_field], TableMetaMetaType.find_by_name(params[:table_name])]).category
    if params[:type] == "Change"
      @source.entity_on_list.each do |i|
        if params[:table_name]=="people"
          if type.include?("FK")
            change_forieng_key = (params[:table_field]).camelize.constantize.find_by_name(params[:select_data])

            i.__send__(params[:table_field].to_s.foreign_key+"=" , change_forieng_key.id) unless i.__send__(params[:table_field].to_s).nil?
          else
            i.__send__((params[:table_field].to_s+"=").to_sym, params[:change_value])
          end
          i.save
        else
          # for address, employment, contact

          unless i.__send__(params[:table_name]).empty?
            entity = i.__send__(params[:table_name]).first
            if type.include?("FK")
             if params[:table_field]=="country"
               change_forieng_key = (params[:table_field]).camelize.constantize.find_by_short_name(params[:select_data])
             else
              change_forieng_key = (params[:table_field]).camelize.constantize.find_by_name(params[:select_data])
             end
              entity.__send__(params[:table_field].to_s.foreign_key+"=" , change_forieng_key.id)
            else
        
              entity.__send__((params[:table_field]+"=").to_sym, params[:change_value])

           
            end
            entity.save!
          end

        end

      end

    elsif params[:type] == "Delete"
      @source.entity_on_list.each do |i|
        if params[:table_name]=="people"
          i.__send__((params[:table_field].to_s+"=").to_sym, "")
          i.save
        else
          # for address, employment, contact
          unless i.__send__(params[:table_name]).empty?

            entity = i.__send__(params[:table_name]).first

            entity.__send__((params[:table_field]+"=").to_sym, "")

            entity.save!

          end
        end
      end

    elsif params[:type] == "Add"

      @source.entity_on_list.each do |i|
        if params[:table_name]=="people"
          if params[:add_front] == "true"
            i.__send__((params[:table_field].to_s+"=").to_sym, params[:change_value]+i.__send__(params[:table_field]))
          end
          if params[:add_end] == "true"
            i.__send__((params[:table_field].to_s+"=").to_sym, i.__send__(params[:table_field])+params[:change_value])
          end

          i.save

        else
          
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


        end
      end

    end

    
  end

  # check the field type to show datapicker, integer field , Foreign Key, Complusory Field
  def check_field_type
    @short_name = false
    if(params[:table_field] == "country")
      @short_name = true
  end
    @type = TableMetaType.find(:first, :conditions => ["name = ? AND tag_meta_type_id = ?", params[:table_field], TableMetaMetaType.find_by_name(params[:table_name])]).category
    
    if @type.include?("FK")

      @category = (params[:table_field]).camelize.constantize
    end


    respond_to do |format|
      format.js
    end
  end
end
