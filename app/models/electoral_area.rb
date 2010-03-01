class ElectoralArea < PostArea


  validates_uniqueness_of :division_name, :scope => [:country_id], :case_sensitive => false
  default_scope :order => "post_areas.id ASC"
  has_many :postcodes


   def self.find_electoral_area_by_country_id(id)
    ElectoralArea.find(:all, :conditions => ['country_id=?', id], :order => 'division_name')
  end
end
