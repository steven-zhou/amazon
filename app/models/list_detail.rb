class ListDetail < ActiveRecord::Base
  
  belongs_to :list_header
  belongs_to :person

  validates_presence_of :person, :list_header

end
