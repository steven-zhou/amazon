class MasterDocType < ActiveRecord::Base


  validates_presence_of :name

  belongs_to :master_doc_meta_type
  has_many :master_docs
  has_many :role_conditions

  
end
