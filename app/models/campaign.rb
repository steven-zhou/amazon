class Campaign < ActiveRecord::Base

  has_many :sources, :dependent => :destroy
  has_many :transaction_allocations
  has_many :memberships

  validates_uniqueness_of :name
  validates_presence_of :name, :start_date
  validate :end_date_must_be_equal_or_after_start_date

  def self.active_campaign
    @campaign = Campaign.find(:all, :conditions => ["status = true and to_be_removed = false"], :order => 'name')
  end

  
  after_save :update_children_when_delete

  protected
  def end_date_must_be_equal_or_after_start_date

    errors.add(:end_date, "can't be before start date") if (!end_date.nil? && !start_date.nil? && end_date < start_date)

  end

  private

  def update_children_when_delete
    if self.to_be_removed == true
      self.sources.each do |i|
        if i.to_be_removed == false
          i.to_be_removed = true
          i.save
        end
      end
    end
  end

 

end
