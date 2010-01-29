class Campaign < ActiveRecord::Base

  has_many :sources, :dependent => :destroy
  has_many :transaction_allocations

  validates_uniqueness_of :name
  validates_presence_of :name, :start_date
  validate :end_date_must_be_equal_or_after_start_date

  def self.active_campaign
    @campaign = Campaign.find(:all, :conditions => ["status = true and to_be_removed = false"], :order => 'name')
  end


   protected
  def end_date_must_be_equal_or_after_start_date

    errors.add(:end_date, "can't be before start date") if (!end_date.nil? && !start_date.nil? && end_date < start_date)

  end


end
