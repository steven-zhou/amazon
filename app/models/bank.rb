class Bank < ActiveRecord::Base


  belongs_to :country

  validates_presence_of :full_name, :message => "You must specify a full name for a bank."
  validates_presence_of :short_name, :message => "You must specify a short name for a bank."
  validates_presence_of :branch_name, :message => "You must specify a branch name."
  validates_presence_of :branch_number, :message => "You must specify a branch number."

  def display_name
    "#{self.short_name}, #{self.branch_name}"
  end
  
end
