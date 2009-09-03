class QueryHeader < ActiveRecord::Base

  has_many :query_details
  has_many :query_criterias

  validates_uniqueness_of :name

  accepts_nested_attributes_for :query_details, :reject_if => proc { |attributes| attributes['table_name'].blank? || attributes['field_name'].blank? }
  accepts_nested_attributes_for :query_criterias, :reject_if => proc { |attributes| attributes['table_name'].blank? || attributes['field_name'].blank? || attributes['operator'].blank?}

end
