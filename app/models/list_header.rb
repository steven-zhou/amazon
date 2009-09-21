class ListHeader < ActiveRecord::Base



  belongs_to :query_header
  has_many :list_details, :order => "id"
  has_many :user_lists
  has_many :people_on_list, :through => :list_details, :source => :person

  has_many :players, :through => :list_details, :source => :person

  validates_uniqueness_of :name, :case_sensitive => false
  validates_presence_of :name, :query_header

  def formatted_info
    "#{self.name} - #{self.description} : #{self.list_size} records"
  end

  def self.sortall
    ListHeader.find(:all, :order => "id")
  end
end
