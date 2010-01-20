class PersonListHeader < ListHeader
  has_many :entity_on_list, :through => :list_details, :source => :person, :order => "entity_id"

  def self.saved_lists
    PersonListHeader.find(:all, :order => "name")
  end
end
