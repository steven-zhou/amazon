class ListDetail < ActiveRecord::Base
  
  belongs_to :person, :foreign_key => "listable_id"
  belongs_to :organisation, :foreign_key => "listable_id"
  belongs_to :list_header

  validates_presence_of :listable_id, :list_header

  after_create :plus_list_size
  before_destroy :minus_list_size

  private

  def plus_list_size
    self.list_header.list_size = self.list_header.list_size.nil? ? 1 : self.list_header.list_size + 1
    self.list_header.save
  end
  def minus_list_size
    self.list_header.list_size = self.list_header.list_size - 1
    self.list_header.save
  end
end
