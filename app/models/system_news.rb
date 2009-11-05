class SystemNews < ActiveRecord::Base

  belongs_to :created_by, :class_name => "LoginAccount", :foreign_key => "created_by_id"
  belongs_to :updated_by, :class_name => "LoginAccount", :foreign_key => "updated_by_id"

  def short_description
    "#{self.description[0,80]} ..."
  end
end
