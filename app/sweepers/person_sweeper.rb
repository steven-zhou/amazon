class PersonSweeper < ActionController::Caching::Sweeper
  observe Person

  def after_save(person)
    expire_cache(person)
  end

  def after_destroy(person)
    expire_cache(person)
  end

  def after_update(person)
    expire_cache(person)
  end

  def expire_cache(person)
    expire_page :controller => "people", :action => 'show_list', :format => 'js'
  end

end
