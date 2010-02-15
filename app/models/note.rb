class Note < ActiveRecord::Base
  belongs_to :noteable, :polymorphic => true
  belongs_to :note_type, :class_name => "NoteType", :foreign_key => "note_type_id"

  
  validates_presence_of :note_type_id
  validates_presence_of :label
  validates_uniqueness_of :label, :scope => [:note_type_id, :noteable_type, :noteable_id]


  def self.find_person_note(id,note_type_id,label)
    Note.find(:first,:conditions=>["noteable_id = ? and note_type_id =? and label =? and noteable_type= 'Person' ",id,note_type_id,label])
  end

    def self.find_all_person_note(id,value,note_type_id)
    Note.find(:all,:conditions=>["noteable_id = ? and label = ? and note_type_id =? and noteable_type= 'Person' ",id,value,note_type_id])
  end

end
