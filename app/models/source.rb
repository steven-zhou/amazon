class Source < ActiveRecord::Base

  belongs_to :campaign

  validates_presence_of :campaign_id
  validates_uniqueness_of :name, :scope => [:campaign_id]


end
