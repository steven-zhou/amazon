class QueryHeader < ActiveRecord::Base

  has_many :query_details
  has_many :query_selections
  has_many :query_sorters
  has_many :query_criterias

  validates_presence_of :name
  validates_uniqueness_of :name

  accepts_nested_attributes_for :query_selections, :query_sorters, :reject_if => proc { |attributes| attributes['table_name'].blank? || attributes['field_name'].blank? }
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

  def condition_clauses
    condition_clauses = Array.new
    operator_arr = Array.new
    self.query_criterias.find(:all, :order => "sequence").each do |i|
      operator_arr = QueryCriteria::OPERATORS[i.operator]
      if(i.sequence == 1)
        condition_clauses.push("#{i.table_name}.#{i.field_name} #{operator_arr[0]} ?")
      else
        condition_clauses.push("#{i.option} #{i.table_name}.#{i.field_name} #{operator_arr[0]} ?")
      end
    end
    condition_clauses
  end  

  def value_clauses
    value_clauses = Array.new
    operator_arr = Array.new
    self.query_criterias.find(:all, :order => "sequence").each do |i|
      operator_arr = QueryCriteria::OPERATORS[i.operator]
      value_clauses.push("#{operator_arr[1]}#{i.value}#{operator_arr[2]}")
    end
    value_clauses
  end

  def sort_clauses
    sort_clauses = Array.new
    self.query_sorters.find(:all, :order => "sequence").each do |i|
      if i.ascending
      sort_clauses.push("#{i.table_name}.#{i.field_name}")
      else
        sort_clauses.push("#{i.table_name}.#{i.field_name} DESC")
      end
    end
    sort_clauses
  end

   def run
     if self.sort_clauses.empty?
    Person.find(:all, :conditions => [self.condition_clauses.join(" "), *self.value_clauses], :order => "people.id")
     else
       Person.find(:all, :conditions => [self.condition_clauses.join(" "), *self.value_clauses], :order => sort_clauses.join(", "))
     end
  end

  
  def selection_fields
    selection_clauses = Array.new
    selection_clauses.push("People.id")
    self.query_selections.find(:all, :order => "sequence").each do |i|
      selection_clauses.push("#{i.table_name}.#{i.field_name}")
    end
    selection_clauses.join(", ")
  end

  def from_tables
    from_clauses = Array.new
    self.query_criterias.each do |i|
      from_clauses.push("#{i.table_name}") if !from_clauses.include?("#{i.table_name}")
    end

    self.query_selections.each do |i|
      from_clauses.push("#{i.table_name}") if !from_clauses.include?("#{i.table_name}")
    end

    self.query_sorters.each do |i|
      from_clauses.push("#{i.table_name}") if !from_clauses.include?("#{i.table_name}")
    end

    from_clauses.join(" JOIN ")
  end

  def condition_sql_clauses
    condition_clauses = Array.new
    operator_arr = Array.new
    self.query_criterias.find(:all, :order => "sequence").each do |i|
      operator_arr = QueryCriteria::OPERATORS[i.operator]
      if(i.sequence == 1)
        condition_clauses.push("#{i.table_name}.#{i.field_name} #{operator_arr[0]}")
      else
        condition_clauses.push("#{i.option} #{i.table_name}.#{i.field_name} #{operator_arr[0]}")
      end
    end

    value_clauses = self.value_clauses
    condition_clauses.each_index {|x| condition_clauses[x] = condition_clauses[x] + " " + value_clauses[x]}
    condition_clauses
  end




  def sql_statements
    result = "<p>SELECT #{self.selection_fields} </p>"
    result += "<p>FROM #{self.from_tables} </p"
    result += "<p>WHERE #{self.condition_sql_clauses.join(", ")} </p"
    result += "<p>ORDER BY #{self.sort_clauses.join(", ")}</p" if !self.sort_clauses.empty?
    result
  end

 
end

  