class Extra < ActiveRecord::Base

  ################
  #  Associations
  ################

  belongs_to :entity, :polymorphic => true

end
