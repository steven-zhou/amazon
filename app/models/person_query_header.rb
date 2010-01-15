class PersonQueryHeader < QueryHeader

    def self.saved_queries
    PersonQueryHeader.find(:all, :conditions => ["query_headers.group = ?", "save"], :order => "id")
  end

      def run
    if (self.sort_clauses.empty?)
      if (self.include_clauses.empty?)
        Person.find(:all, :conditions => [self.condition_clauses.join(" "), *self.value_clauses], :order => "people.id")
      else
        Person.find(:all, :conditions => [self.condition_clauses.join(" "), *self.value_clauses], :include => [*self.include_clauses], :order => "people.id")
      end
    else
      if (self.include_clauses.empty?)
        Person.find(:all, :conditions => [self.condition_clauses.join(" "), *self.value_clauses], :order => self.sort_clauses.join(", "))
      else
        Person.find(:all, :conditions => [self.condition_clauses.join(" "), *self.value_clauses], :order => self.sort_clauses.join(", "), :include => [*self.include_clauses])
      end
    end
  end

       def selection_fields
    selection_clauses = Array.new
    selection_clauses.push("people.id")
    self.query_selections.find(:all, :order => "sequence").each do |i|
      selection_clauses.push("#{i.table_name}.#{i.field_name}")
    end
    selection_clauses.join(", ")
  end

  def from_tables
    from_clauses = Array.new
    from_clauses.push("people")
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

end


