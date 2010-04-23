class PaymentFrequency < AmazonSetting

  acts_as_list

  has_many :employments
  has_many :fee_items,:class_name=>"FeeItem",:foreign_key=>"payment_frequency_id"

  validates_presence_of :name
  validates_uniqueness_of :name, :message => "A payment frequency already exists with the same name."

  after_create :assign_priority
  before_destroy :reorder_priority

  def self.active_payment_frequency
    @payment_frequency = PaymentFrequency.find(:all, :conditions => ["status = true and to_be_removed = false"], :order => 'name')
  end

  private

  def assign_priority
    self.move_to_bottom
  end

  def reorder_priority
    self.remove_from_list
  end
  
end
