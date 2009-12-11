class KeywordLinksController < ApplicationController
  # No System logging done here...

  def add_key
    if params[:person_id].nil?
      @entity = Organisation.find(params[:organisation_id])

    else
     @entity = Person.find(params[:person_id])
    end



    if (!params[:add_person_keywords].nil?)
      params[:add_person_keywords].each do |keyword_id|
        keyword = Keyword.find(keyword_id);
        @selected_class = keyword.keyword_type_name
        @entity.keywords<<keyword
      end
    end

     if (!params[:add_organisation_keywords].nil?)
      params[:add_organisation_keywords].each do |keyword_id|
        keyword = Keyword.find(keyword_id);
        @entity.keywords<<keyword
      end
    end

    if params[:person_id].nil?
        render "/organisations/add_keywords.js"
    else
      render "/people/add_keywords.js"
    end
    
  end

  def remove_key
    if params[:person_id].nil?
      @entity = Organisation.find(params[:organisation_id])
    else
       @entity = Person.find(params[:person_id])
    end
   

   if (!params[:remove_person_keywords].nil?)
      params[:remove_person_keywords].each do |keyword_id|
        keyword = Keyword.find(keyword_id)
        if keyword.to_be_removed == false
        @selected_class = keyword.keyword_type_name
        @entity.keywords.delete(keyword)
        end
      end
    end

     if (!params[:remove_organisation_keywords].nil?)
      params[:remove_organisation_keywords].each do |keyword_id|
        keyword = Keyword.find(keyword_id)
        @entity.keywords.delete(keyword)
      end
    end
      if params[:person_id].nil?
          render "/organisations/remove_keywords.js"
      else
        render "/people/remove_keywords.js"
      end
    
  end


end
