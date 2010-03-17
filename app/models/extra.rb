class Extra < ActiveRecord::Base

  ################
  #  Associations
  ################

  belongs_to :entity, :polymorphic => true

  private

  def self.find_extra(group_id, entity)
    entity.extras.find_by_group_id(group_id)
  end
end
