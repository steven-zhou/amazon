class QueryHeader < ActiveRecord::Base

  has_many :query_details
  has_many :query_criterias

  validates_uniqueness_of :name
end
