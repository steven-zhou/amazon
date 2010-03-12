class MembershipLog < ActiveRecord::Base

  belong_to :person
  belong_to :membership
  belong_to :performer, :class_name => "Person", :foreign_key => "performer_id"

  validates_presence_of :person, :membership, :performer

  default_scope :order => "performed_at"
end
