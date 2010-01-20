class QueryDetail < ActiveRecord::Base

  belongs_to :query_header

  validates_presence_of :table_name, :field_name

   def set_data_type(param1, param2)
     self.data_type = TableMetaType.find(:first, :conditions => ["name = ? AND tag_meta_type_id = ?", param1, TableMetaMetaType.find_by_name(param2)]).category
  end
  

end
