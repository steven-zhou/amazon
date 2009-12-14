class KeywordType < AmazonSetting

  acts_as_list

  validates_presence_of :name
  validates_uniqueness_of :name, :message => "A keyword type already exists with the same name."

  after_create :assign_priority
  before_destroy :reorder_priority

  has_many :keywords

  def self.active_keyword_type
    @keyword_type = KeywordType.find(:all, :conditions => ["status = true and to_be_removed = false"], :order => 'name')
  end
  
  def self.distinct_active_keyword_type   # find all the active keyword type into the drop down list style
    @keyword_type = KeywordType.find(:all, :conditions => ["status = true and to_be_removed = false"], :order => 'name')
    results = ""
    @keyword_type.each {|setting| results += "<option value='"+"#{setting.id}"+"'>" + "#{setting.name}" + "</option>"}
    return results
  end
  

  private

  def assign_priority
    self.move_to_bottom
  end

  def reorder_priority
    self.remove_from_list
  end
  
end
