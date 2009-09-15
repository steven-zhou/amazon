class Group < ActiveRecord::Base


  #belongs_to :group_owner, :class_name => "Person", :foreign_key => "group_owner"
  
  #belongs_to :group_type, :class_name => "GroupType", :foreign_key => "tags_id"

  validates_uniqueness_of :name, :scope => "tags_id", :message => "A group already exists with the same name."

  validates_presence_of :name

  has_many :user_groups
  has_many :login_accounts, :through => :user_groups, :uniq => true

 
  
end
