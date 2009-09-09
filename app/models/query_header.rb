class QueryHeader < ActiveRecord::Base

  has_many :query_details
  has_many :query_criterias

  validates_presence_of :name
  validates_uniqueness_of :name

  accepts_nested_attributes_for :query_details, :reject_if => proc { |attributes| attributes['table_name'].blank? || attributes['field_name'].blank? }
  accepts_nested_attributes_for :query_criterias, :reject_if => proc { |attributes| attributes['table_name'].blank? || attributes['field_name'].blank? || attributes['operator'].blank?}

  def self.random_name
    letter=("a".."z").to_a
    @name = letter[rand(letter.length)] + "#{rand(9)}"+letter[rand(letter.length)]
    @name += letter[rand(letter.length)]+letter[rand(letter.length)]+"#{rand(9)}"+letter[rand(letter.length)]
    @name += letter[rand(letter.length)]+"#{rand(9)}"+letter[rand(letter.length)]+letter[rand(letter.length)]
    @name += letter[rand(letter.length)]+letter[rand(letter.length)]+"#{rand(9)}"
  end

  def self.saved_queries
    QueryHeader.find_all_by_group("save")
  end

  def formatted_info
    "#{self.name} - #{self.description}"
  end
end
