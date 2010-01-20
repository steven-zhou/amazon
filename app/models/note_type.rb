class NoteType < AmazonSetting

  acts_as_list

  validates_presence_of :name
  validates_uniqueness_of :name, :message => "A note type already exists with the same name."

  named_scope :membership, :conditions => {:name => "Membership"}

  after_create :assign_priority
  before_destroy :reorder_priority

  def self.active_note_type
    @note_type = NoteType.find(:all, :conditions => ["status = true"], :order => 'name')
  end

  private

  def assign_priority
    self.move_to_bottom
  end

  def reorder_priority
    self.remove_from_list
  end
  
end
