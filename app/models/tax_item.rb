class TaxItem < ActiveRecord::Base

  has_one :fee_item, :class_name => "FeeItem", :foreign_key => "tax_item_id"
  validates_presence_of :name
  validates_uniqueness_of :name


  before_create :update_to_be_removed_and_status

  def self.active_record
  TaxItem.find(:all, :conditions => ["active = true and to_be_removed = false"], :order => 'name')
  end

  private

  def update_to_be_removed_and_status

    self.to_be_removed = false
    true
  end
end
