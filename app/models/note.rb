class Note < ActiveRecord::Base
  belongs_to :noteable, :polymorphic => true
  belongs_to :note_type
  
  validates_presence_of :note_type_id

end
