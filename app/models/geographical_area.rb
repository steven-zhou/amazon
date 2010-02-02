class GeographicalArea < PostArea

  
  validates_uniqueness_of :division_name, :scope => [:country_id], :case_sensitive => false
   default_scope :order => "post_areas.id ASC"


  def self.find_geographical_area_by_country_id(id)
    GeographicalArea.find(:all, :conditions => ['country_id=?', id], :order => 'division_name')
  end
end
