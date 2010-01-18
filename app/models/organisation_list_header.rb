class OrganisationListHeader < ListHeader
  has_many :entity_on_list, :through => :list_details, :source => :organisation

  def self.saved_lists
    OrganisationListHeader.find(:all, :order => "name")
  end
end
