class SystemNews < ActiveRecord::Base

  belongs_to :created_by, :class_name => "LoginAccount", :foreign_key => "created_by_id"
  belongs_to :updated_by, :class_name => "LoginAccount", :foreign_key => "updated_by_id"

  validates_uniqueness_of :title
  validates_presence_of :title, :description

  def short_description
    "#{self.description[0,80]} ..."
  end

  def self.first_three
    SystemNews.find(:all, :conditions => ["status = ?", true], :order => "created_at DESC", :limit => 3)
  end

  def self.last_three
    active_number = SystemNews.find_all_by_status(true).size
    offset_left = active_number % 3
    offset_number = active_number / 3
    SystemNews.find(:all, :conditions => ["status = ?", true], :order => "created_at DESC", :offset => (offset_left == 0) ? (offset_number-1)*3 : offset_number*3, :limit => 3)
  end
end
