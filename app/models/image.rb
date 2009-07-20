class Image < ActiveRecord::Base
  belongs_to :imageable, :polymorphic => true
  acts_as_fleximage
end


