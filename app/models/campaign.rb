class Campaign < ActiveRecord::Base

  has_many :sources, :dependent => :destroy
  has_many :transaction_allocations

  validates_uniqueness_of :name
  validates_presence_of :name, :start_date

  def self.active_campaign
    @campaign = Campaign.find(:all, :conditions => ["status = true"], :order => 'name')
  end

end
