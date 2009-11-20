class PostArea < ActiveRecord::Base

  validates_presence_of :division_name
  belongs_to :country
 

end
