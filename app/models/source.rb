class Source < ActiveRecord::Base

  belongs_to :campaign
   has_many :transaction_allocations

  validates_presence_of :campaign_id, :name
  validates_uniqueness_of :name, :scope => [:campaign_id]

  def self.active_source
    @source = Source.find(:all, :conditions => ["status = true and to_be_removed = false"], :order => 'name')
  end

    after_save :update_parent_when_retrieve

  private
    def update_parent_when_retrieve
    if self.to_be_removed == false && self.campaign.to_be_removed == true
      self.campaign.to_be_removed = false
      self.campaign.save
    end
  end

end
