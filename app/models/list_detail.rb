class ListDetail < ActiveRecord::Base
  
  belongs_to :list_header
  belongs_to :person

  validates_presence_of :person, :list_header

  after_save :plus_list_size
  before_destroy :minus_list_size

  private

  def plus_list_size
    self.list_header.list_size = self.list_header.list_size + 1
    self.list_header.save
  end
  def minus_list_size
    self.list_header.list_size = self.list_header.list_size - 1
    self.list_header.save
  end
end
