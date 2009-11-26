class Campaign < ActiveRecord::Base

  has_many :sources

  validates_uniqueness_of :name
  validates_presence_of :start_date, :status

end
