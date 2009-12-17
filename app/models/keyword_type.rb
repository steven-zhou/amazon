class KeywordType < AmazonSetting

  acts_as_list

  validates_presence_of :name
  validates_uniqueness_of :name, :message => "A keyword type already exists with the same name."

  after_create :assign_priority
  before_destroy :reorder_priority
  after_save :update_keywords_when_delete

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

  def update_keywords_when_delete
    if self.to_be_removed == true
      self.keywords.each do |i|
        if i.to_be_removed == false
          i.to_be_removed = true
          i.save
        end
      end
    end
  end

  def check_keyword
    
  end
  
end
