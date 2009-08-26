class RoleCondition < ActiveRecord::Base

 
  belongs_to :master_doc_type, :class_name => "MasterDocType", :foreign_key => "doctype_id"
  belongs_to :role

  delegate :name, :to => :master_doc_type


  validates_presence_of :doctype_id
  validates_presence_of :role_id
  validate :doctype_must_exist
  validate :role_must_exist
  validates_uniqueness_of :doctype_id

  def doctype_must_exist
    errors.add(:doctype_id, "You must specify a doctype that exists.") if (doctype_id && MasterDocType.find_by_id(doctype_id).nil?)
  end
  def role_must_exist
    errors.add(:role_id, "You must specify a role that exists.") if (role_id && Role.find_by_id(role_id).nil?)
  end


end
