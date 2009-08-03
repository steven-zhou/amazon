class MasterDocMetaMetaType < ActiveRecord::Base


  validates_presence_of :name

  has_many :master_doc_meta_types

  
end
