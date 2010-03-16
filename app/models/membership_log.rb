class MembershipLog < ActiveRecord::Base

  belongs_to :person
  belongs_to :membership
  belongs_to :performer, :class_name => "Person", :foreign_key => "performer_id"

  validates_presence_of :person, :membership, :performer

  default_scope :order => "created_at"
end
