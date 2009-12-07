class MessageTemplate < ActiveRecord::Base

  validates_presence_of :body, :name

  validates_uniqueness_of :name

end
