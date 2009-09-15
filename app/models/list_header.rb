class ListHeader < ActiveRecord::Base

  has_many :list_details
  belongs_to :query_header

  validates_uniqueness_of :name
  validates_presence_of :name, :query_header

end
