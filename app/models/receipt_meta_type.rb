class ReceiptMetaType < TagType

  acts_as_list

  belongs_to :receipt_meta_meta_type, :class_name => "ReceiptMetaMetaType", :foreign_key => "tag_meta_type_id"
  has_many :transaction_headers
 
  validates_presence_of :name
  validates_uniqueness_of :name,:scope => :tag_meta_type_id

  after_create :assign_priority
  before_destroy :reorder_priority

  def self.active_receipt_meta_type
    @receipt_meta_type = ReceiptMetaType.find(:all, :conditions => ["status = true and to_be_removed = false"], :order => 'name')
  end

  private

  def assign_priority
    self.move_to_bottom
  end

  def reorder_priority
    self.remove_from_list
  end

end
