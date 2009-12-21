class ElectoralArea < PostArea


  validates_uniqueness_of :division_name, :scope => [:country_id], :case_sensitive => false
  default_scope :order => "post_areas.id ASC"
end
