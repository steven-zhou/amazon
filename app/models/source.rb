class Source < ActiveRecord::Base

  belongs_to :campaign
   has_many :transaction_allocations

  validates_presence_of :campaign_id, :name
  validates_uniqueness_of :name, :scope => [:campaign_id]


end
