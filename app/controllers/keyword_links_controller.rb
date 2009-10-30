class KeywordLinksController < ApplicationController

  def add_key
    if params[:person_id].nil?
      @entity = Organisation.find(params[:organisation_id])

    else
     @entity = Person.find(params[:person_id])
    end
    

    unless params[:add_keywords].nil?
      params[:add_keywords].each do |keyword_id|
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
   

    unless params[:remove_keywords].nil?
      params[:remove_keywords].each do |keyword_id|
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


#   def add_keywords
#
#    unless params[:add_keywords].nil?
#      params[:add_keywords].each do |keyword_id|
#        keyword = Keyword.find(keyword_id);
#        @organisation.keywords<<keyword
#      end
#    end
#
#  end
#
#  def remove_keywords
#    @organisation = Organisation.find(params[:id])
#
#    unless params[:remove_keywords].nil?
#      params[:remove_keywords].each do |keyword_id|
#        keyword = Keyword.find(keyword_id)
#        @organisation.keywords.delete(keyword)
#      end
#    end
#    render "remove_keywords.js"
#  end

end
