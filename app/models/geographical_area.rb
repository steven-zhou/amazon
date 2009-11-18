class GeographicalArea < PostArea

  validates_presence_of :division_name
  validates_uniqueness_of :division_name, :scope => [:country_id], :case_sensitive => false
   default_scope :order => "country_name ASC"
end
