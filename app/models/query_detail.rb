class QueryDetail < ActiveRecord::Base

  belongs_to :query_header

  validates_presence_of :table_name, :field_name

end
