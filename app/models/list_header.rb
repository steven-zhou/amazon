class ListHeader < ActiveRecord::Base



  belongs_to :query_header
  has_many :list_details, :order => "id"
  has_many :user_lists

  has_many :group_lists
  has_many :people_on_list, :through => :list_details, :source => :person

#  has_many :user_list_headers,:through => :user_lists, :uniq => true

  has_many :group_types, :through => :group_lists, :uniq => true
  #has_many :players, :through => :list_details, :source => :person

  validates_uniqueness_of :name, :case_sensitive => false
  validates_presence_of :name

  before_destroy :delete_all_details

  def formatted_info
    "#{self.name} - #{self.description} : #{self.list_size} records"
  end

  def self.sortall
    ListHeader.find(:all, :conditions => ["type is null"], :order => "name")
  end

  def self.all
    ListHeader.find(:all, :order => "name")
  end

  private

  def delete_all_details
    self.list_details.each do |list_detail|
      list_detail.destroy
    end
  end
end
