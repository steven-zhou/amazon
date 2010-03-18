class Extra < ActiveRecord::Base

  ################
  #  Associations
  ################

  belongs_to :entity, :polymorphic => true
  belongs_to :group, :class_name => "ExtraMetaType", :foreign_key => "group_id"
  belongs_to :label1, :class_name => "ExtraType", :foreign_key => "label1_id"
  belongs_to :label2, :class_name => "ExtraType", :foreign_key => "label1_id"
  belongs_to :label3, :class_name => "ExtraType", :foreign_key => "label1_id"
  belongs_to :label4, :class_name => "ExtraType", :foreign_key => "label1_id"
  belongs_to :label5, :class_name => "ExtraType", :foreign_key => "label1_id"
  belongs_to :label6, :class_name => "ExtraType", :foreign_key => "label1_id"

  before_save :update_group_value

  private

  def update_group_value
    values = Array.new
    values << self.label1_value
    values << self.label2_value
    values << self.label3_value
    values << self.label4_value
    values << self.label5_value
    values << self.label6_value
    self.group_value = values.join(", ")
  end

  def self.find_extra(group_id, entity)
    entity.extras.find_by_group_id(group_id)
  end
end
