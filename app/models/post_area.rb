class PostArea < ActiveRecord::Base

  validates_presence_of :division_name
  belongs_to :country
 
  before_destroy :delete_all_links

  private

  def delete_all_links
    self.postcodes.each do |i|
      i.geographical_area_id = nil if self.class.to_s == "GeographicalArea"
      i.electoral_area_id = nil if self.class.to_s == "ElectoralArea"
      i.save
    end
  end
end
