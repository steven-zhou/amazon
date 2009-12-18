class Source < ActiveRecord::Base

  belongs_to :campaign
   has_many :transaction_allocations

  validates_presence_of :campaign_id, :name
  validates_uniqueness_of :name, :scope => [:campaign_id]

  def self.active_source
    @source = Source.find(:all, :conditions => ["status = true"], :order => 'name')
  end

end
