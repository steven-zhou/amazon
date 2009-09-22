class GroupList < ActiveRecord::Base


  belongs_to :list_header, :foreign_key => "list_header_id"
  belongs_to :group_type, :foreign_key => "tag_id"

  validates_presence_of :list_header_id, :tag_id

end
