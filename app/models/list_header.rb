class ListHeader < ActiveRecord::Base



  belongs_to :query_header
  has_many :list_details
  has_many :user_lists

  has_many :players, :through => :list_details, :source => :person

  validates_uniqueness_of :name
  validates_presence_of :name, :query_header


end
