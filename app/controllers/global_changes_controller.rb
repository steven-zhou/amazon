class GlobalChangesController < ApplicationController

  def index
     @list_headers = @current_user.all_person_lists
     respond_to do |format|
      format.html
    end
  end


  def change_value

    @source = PersonListHeader.find(params[:source_id].to_i) rescue @source = PrimaryList.find(params[:source_id].to_i)

    if params[:type] == "Change"
      puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"

       @source.entity_on_list.each do |i|
      if params[:table_name]=="people"
        i.__send__((params[:table_field].to_s+"=").to_sym, params[:change_value])
        i.save
      end

       if params[:table_name]=="addresses"
         puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
        i.addresses.first.__send__((params[:table_field].to_s+"=").to_sym, params[:change_value]) unless i.addresses.first.nil?
        i.save
      end


    end

    elsif params[:type] == "Delete"
     @source.entity_on_list.each do |i|
      if params[:table_name]=="people"
        i.__send__((params[:table_field].to_s+"=").to_sym, "")
        i.save
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
      end
      end

    end

    
    puts params[:table_name]

    puts params[:table_field]
    puts params[:change_value]
    puts params[:type]
    
  end
end
