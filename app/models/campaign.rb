class Campaign < ActiveRecord::Base

  has_many :sources, :dependent => :destroy

  validates_uniqueness_of :name
  validates_presence_of :name, :start_date, :status

end
