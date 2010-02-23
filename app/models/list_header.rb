class ListHeader < ActiveRecord::Base

 has_many :list_details, :dependent => :destroy

  has_many :user_lists
  has_many :login_accounts, :through => :user_lists, :uniq => true
  
  has_many :group_lists
  has_many :group_types, :through => :group_lists, :uniq => true
  
  #has_many :players, :through => :list_details, :source => :person

  validates_uniqueness_of :name, :case_sensitive => false
  validates_presence_of :name

  before_destroy :delete_all_details, :delete_all_user_group_list

  def formatted_info
    "#{self.name} - #{self.description} : #{self.list_size} records"
  end

  def person_list?
    self.class.to_s == "PersonListHeader" || self.class.to_s == "PrimaryList" || self.class.to_s == "TempList"
  end

   def organisation_list?
    self.class.to_s == "OrganisationListHeader" || self.class.to_s == "OrganisationPrimaryList"
  end

  protected
  
  def delete_all_details
    self.list_details.each do |list_detail|
      list_detail.destroy
    end
  end

  def delete_all_user_group_list

    unless self.group_lists.nil? 
      self.group_lists.each do |gl|
        gl.destroy
      end
    end

    unless self.user_lists.nil?
      self.user_lists.each do |ul|
        ul.destroy
      end
    end
  end
end
