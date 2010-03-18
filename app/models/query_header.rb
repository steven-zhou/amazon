class QueryHeader < ActiveRecord::Base

  has_many :query_details
# has_many :list_headers

  has_many :query_selections, :order => "sequence"
  has_many :query_sorters, :order => "sequence"
  has_many :query_criterias, :order => "sequence"


  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false

  accepts_nested_attributes_for :query_selections, :query_sorters, :reject_if => proc { |attributes| attributes['table_name'].blank? || attributes['field_name'].blank? }
  accepts_nested_attributes_for :query_criterias, :reject_if => proc { |attributes| attributes['table_name'].blank? || attributes['field_name'].blank? || attributes['operator'].blank?}

  def self.random_name
    letter=("a".."z").to_a
    @name = letter[rand(letter.length)] + "#{rand(9)}"+letter[rand(letter.length)]
    @name += letter[rand(letter.length)]+letter[rand(letter.length)]+"#{rand(9)}"+letter[rand(letter.length)]
    @name += letter[rand(letter.length)]+"#{rand(9)}"+letter[rand(letter.length)]+letter[rand(letter.length)]
    @name += letter[rand(letter.length)]+letter[rand(letter.length)]+"#{rand(9)}"
  end

#  def self.saved_queries
#    QueryHeader.find(:all, :conditions => ["query_headers.group = ?", "save"], :order => "id")
#  end

  def formatted_info
    "#{self.name} - #{self.description}"
  end

  def condition_clauses
    condition_clauses = Array.new
    operator_arr = Array.new
    self.query_criterias.find(:all, :order => "sequence").each do |i|
      operator_arr = QueryCriteria::OPERATORS[i.operator]
      if(i.sequence == 1)

        if(i.data_type == "Integer FK")
          condition_clauses.push("#{i.table_name}.#{i.field_name}_id IN (?)")
        else
          condition_clauses.push("#{i.table_name}.#{i.field_name} #{operator_arr[0]} ?")
        end


      else

        if(i.data_type == "Integer FK")
          condition_clauses.push("#{i.option} #{i.table_name}.#{i.field_name}_id IN (?)")
        else
          condition_clauses.push("#{i.option} #{i.table_name}.#{i.field_name} #{operator_arr[0]} ?")
        end

      end
    end
    condition_clauses
  end  

  def value_clauses
    value_clauses = Array.new
    operator_arr = Array.new
    self.query_criterias.find(:all, :order => "sequence").each do |i|
      operator_arr = QueryCriteria::OPERATORS[i.operator]

      if(i.data_type == "Integer FK")
        if(i.field_name == "country")
          value_clauses.push(i.field_name.camelize.constantize.find(:all, :conditions => ["short_name #{operator_arr[0]} ?", "#{operator_arr[1]}#{i.value}#{operator_arr[2]}"]))
        else
          value_clauses.push(i.field_name.camelize.constantize.find(:all, :conditions => ["name #{operator_arr[0]} ?", "#{operator_arr[1]}#{i.value}#{operator_arr[2]}"]))
        end
      else
        value_clauses.push("#{operator_arr[1]}#{i.value}#{operator_arr[2]}")
      end

    end
    value_clauses
  end

  def sort_clauses
    sort_clauses = Array.new
    self.query_sorters.find(:all, :order => "sequence").each do |i|
      if (i.data_type == "Integer FK")
        if i.ascending
          sort_clauses.push("#{i.table_name}.#{i.field_name}_id")
        else
          sort_clauses.push("#{i.table_name}.#{i.field_name}_id DESC")
        end
      else
        if i.ascending
          sort_clauses.push("#{i.table_name}.#{i.field_name}")
        else
          sort_clauses.push("#{i.table_name}.#{i.field_name} DESC")
        end
      end
    end
    sort_clauses
  end

  def include_clauses
    include_tables = Array.new
    self.query_criterias.each do |i|
      include_tables.push("#{i.table_name}") if !include_tables.include?("#{i.table_name}")
    end

    self.query_selections.each do |i|
      include_tables.push("#{i.table_name}") if !include_tables.include?("#{i.table_name}")
    end

    self.query_sorters.each do |i|
      include_tables.push("#{i.table_name}") if !include_tables.include?("#{i.table_name}")
    end
    include_tables.delete("people") if include_tables.include?("people")
    include_tables.delete("organisations") if include_tables.include?("organisations")
    include_tables
  end


  def sql_value_clauses
    sql_value_clauses = Array.new
    sql_operator_arr = Array.new
    self.query_criterias.find(:all, :order => "sequence").each do |i|
      sql_operator_arr = QueryCriteria::OPERATORS[i.operator]
      sql_value_clauses.push("#{sql_operator_arr[1]}#{i.value}#{sql_operator_arr[2]}")
    end
    sql_value_clauses
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

    sql_value_clauses = self.sql_value_clauses
    condition_clauses.each_index {|x| condition_clauses[x] = condition_clauses[x] + " " + sql_value_clauses[x]}
    condition_clauses
  end

  def sql_statements
    result = "<p>SELECT #{self.selection_fields} </p>"
    result += "<p>FROM #{self.from_tables} </p"
    result += "<p>WHERE #{self.condition_sql_clauses.join(", ")} </p"
    result += "<p>ORDER BY #{self.sort_clauses.join(", ")}</p" if !self.sort_clauses.empty?
    result
  end

  def person_query_header?
    self.class.to_s == "PersonQueryHeader"
  end

  def self.saved_query_header
    QueryHeader.find(:all, :conditions => ["query_headers.group =? AND status =?", "save", "true"])
  end
 
end

  