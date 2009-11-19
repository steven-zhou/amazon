class Note < ActiveRecord::Base
  belongs_to :noteable, :polymorphic => true
  belongs_to :note_type, :class_name => "NoteType", :foreign_key => "note_type_id"

  
  validates_presence_of :note_type_id
  validates_presence_of :label

end
