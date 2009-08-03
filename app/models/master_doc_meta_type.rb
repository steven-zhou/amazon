class MasterDocMetaType < ActiveRecord::Base


  validates_presence_of :name

  belongs_to :master_doc_meta_meta_type

  has_many :master_doc_types

  
end
