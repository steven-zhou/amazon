class ToDoList < ActiveRecord::Base

  validates_presence_of :description
  belongs_to :created_by, :class_name => "LoginAccount", :foreign_key => "created_by_id"
  belongs_to :updated_by, :class_name => "LoginAccount", :foreign_key => "updated_by_id"
  belongs_to :login_account

def self.new_to_do(user)
    @new_to_do =  ToDoList.find(:all, :conditions => ["status = ? AND login_account_id = ?", "new", user], :order => "created_at")
  end

def self.processing_to_do(user)
    @processing_to_do =  ToDoList.find(:all, :conditions => ["status = ? AND login_account_id = ?", "processing", user], :order => "created_at")
  end

def self.completed_to_do(user)
    @completed_to_do =  ToDoList.find(:all, :conditions => ["status = ? AND login_account_id = ?", "completed", user], :order => "created_at")
  end
end
