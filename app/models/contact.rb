class Contact < ActiveRecord::Base

#--
################
#  Associations
################
#++

  belongs_to :contact_meta_type
  belongs_to :contactable, :polymorphic => true
  

#--
################ 
#  Validations
################
#++


  #validates_presence_of :priority
  #validates_uniqueness_of :priority, :scope => [:contactable_id, :contactable_type, :contact_type_id]


  def self.phone_types
    ContactMetaType.find(:all, :conditions => ["tag_meta_type_id = ?", ContactMetaMetaType.find_by_name("Phone").id], :order => "name")
  end

  def self.email_types
    ContactMetaType.find(:all, :conditions => ["tag_meta_type_id = ?", ContactMetaMetaType.find_by_name("Email").id], :order => "name")
  end

  def self.fax_types
    ContactMetaType.find(:all, :conditions => ["tag_meta_type_id = ?", ContactMetaMetaType.find_by_name("Fax").id], :order => "name")
  end

  def self.website_types
    ContactMetaType.find(:all, :conditions => ["tag_meta_type_id = ?", ContactMetaMetaType.find_by_name("Website").id], :order => "name")
  end

end
