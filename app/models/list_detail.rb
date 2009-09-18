class ListDetail < ActiveRecord::Base
  
  belongs_to :list_header
  belongs_to :person

  validates_presence_of :person, :list_header

  before_destroy :update_list_size

  private
  def update_list_size
    self.list_header.list_size = self.list_header.list_size - 1
    self.list_header.save
  end
end
