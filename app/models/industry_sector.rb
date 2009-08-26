class IndustrySector < AmazonSetting

  acts_as_list

  validates_presence_of :name
  validates_uniqueness_of :name, :message => "An industry sector already exists with the same name."

  after_create :assign_priority
  before_destroy :reorder_priority

  def self.active_industry_sector
    @industry_sector = IndustrySector.find(:all, :conditions => ["status = true"], :order => 'name')
  end

  private

  def assign_priority
    self.move_to_bottom
  end

  def reorder_priority
    self.remove_from_list
  end
  
end
