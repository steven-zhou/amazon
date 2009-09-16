class ListHeader < ActiveRecord::Base


  belongs_to :query_header
  has_many :list_details
  has_many :user_lists


  validates_presence_of :name
  validates_uniqueness_of :name














  




end
