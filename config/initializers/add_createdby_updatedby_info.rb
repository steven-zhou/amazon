#extend AR:Base two methods to sign creator_id and updater_id to all the modules
class ActiveRecord::Base
  before_create :insert_createdby
  before_update :insert_updatedby

  belongs_to :login_accounts, :class_name=>"LoginAccount", :foreign_key => "creator_id"
  belongs_to :login_accounts, :class_name=>"LoginAccount", :foreign_key => "updater_id"

  private
  def insert_createdby
    self.creator_id = LoginAccount.current_user.id
  end

  def insert_updatedby
    self.updater_id = LoginAccount.current_user.id
  end
end
