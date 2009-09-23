class KeywordLinksController < ApplicationController

  def create
    @person = Person.find(params[:person_id])

    unless params[:add_keywords].nil?
      params[:add_keywords].each do |keyword_id|
        keyword = Keyword.find(keyword_id);
        @person.keywords<<keyword
      end
    end
    render "/people/add_keywords.js"
  end

  def remove
    @person = Person.find(params[:person_id])

    unless params[:remove_keywords].nil?
      params[:remove_keywords].each do |keyword_id|
        keyword = Keyword.find(keyword_id)
        @person.keywords.delete(keyword)
      end
    end
    render "/people/remove_keywords.js"
  end

end
