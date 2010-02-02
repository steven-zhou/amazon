class Postcode < ActiveRecord::Base

  #Association
  belongs_to :country
  belongs_to :geographical_area
  belongs_to :electoral_area

  #Validation
  validates_presence_of :country_id, :postcode, :state, :suburb
    # Removed :geographical_area_id, :electoral_area_id
  # validates_uniqueness_of :postcode, :suburb, :scope => ['country_id', 'state'], :case_sensitive => false

  #Default scope
  default_scope :order => "postcode ASC"

  def self.search_post_code(suburb, state, postcode)
    @post_code = Postcode.find(:all, :conditions => ["suburb ILIKE ? AND state ILIKE ? AND postcode LIKE ?", "%#{suburb}%", "%#{state}%", "%#{postcode}%"])
  end

end
