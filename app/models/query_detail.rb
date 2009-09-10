class QueryDetail < ActiveRecord::Base

  belongs_to :query_header

  validates_presence_of :table_name, :field_name
  validates_uniqueness_of :field_name, :scope => [:query_header_id, :table_name]

end
