class Receipt < ActiveRecord::Base

  belongs_to :deposit

  has_many :allocations

  validates_presence_of :deposit_id
  

end
