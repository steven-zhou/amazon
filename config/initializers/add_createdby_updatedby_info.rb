#extend AR:Base two methods to sign creator_id and updater_id to all the modules
class ActiveRecord::Base
  attr_accessor :callback_flag
  before_create :insert_createdby, :unless => :skip_callback?
  before_update :insert_updatedby

  belongs_to :creator, :class_name=>"LoginAccount", :foreign_key => "creator_id"
  belongs_to :updater, :class_name=>"LoginAccount", :foreign_key => "updater_id"

  private
  def insert_createdby
    self.creator_id = LoginAccount.current_user.id rescue self.creator_id = nil
  end

  def insert_updatedby

    self.updater_id = LoginAccount.current_user.id rescue self.update_id = nil

  end

  def skip_callback?
    self.callback_flag
  end
end
