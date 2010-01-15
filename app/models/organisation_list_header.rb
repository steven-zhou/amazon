class OrganisationListHeader < ListHeader
  has_many :entity_on_list, :through => :list_detail, :source => :organisation
end
