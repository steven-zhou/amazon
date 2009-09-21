class GroupList < ActiveRecord::Base


  belongs_to :list_header, :foreign_key => "list_header_id"
  belongs_to :group_type, :foreign_key => "tag_id"


end
