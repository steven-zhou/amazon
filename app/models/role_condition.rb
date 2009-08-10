class RoleCondition < ActiveRecord::Base

 
  belongs_to :master_doc_type, :class_name => "MasterDocType", :foreign_key => "doctype_id"
  belongs_to :role

  delegate :name, :to => :master_doc_type


#  validates_presence_of :name, :doctype_id
  validates_associated :master_doc_type

end
