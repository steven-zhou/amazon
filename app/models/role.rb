class Role < ActiveRecord::Base

  belongs_to :role_type, :class_name => "RoleType", :foreign_key => "role_type_id"

  has_many :person_roles
  has_many :role_conditions
  has_many :role_players, :through => :person_roles, :source => :role_player
  
  validates_presence_of :name, :role_type_id
  validates_associated :role_type
  validates_uniqueness_of :name,  :scope => [:role_type_id]
  
  delegate :name, :to => :role_type, :prefix => true,:allow_nil => true

  default_scope :order => "id ASC"
  before_destroy :check_assign




  private
  def check_assign
   @check_role_assign= PersonRole.find_by_role_id(self.id)
   if !@check_role_assign.nil?
     return false
   else
     return true
   end
  end

end
