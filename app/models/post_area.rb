class PostArea < ActiveRecord::Base


  belongs_to :country
  validates_presence_of :division_name
  validates_uniqueness_of :division_name, :scope => [:country_id], :case_sensitive => false

end
