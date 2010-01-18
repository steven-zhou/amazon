class PersonListHeader < ListHeader
  has_many :entity_on_list, :through => :list_details, :source => :person
  
end
