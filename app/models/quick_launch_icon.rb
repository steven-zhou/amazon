class QuickLaunchIcon < ActiveRecord::Base

  belongs_to :login_account, :foreign_key => "login_account_id"

  validates_presence_of :login_account_id
  validates_uniqueness_of :login_account_id, :scope => [:controller, :action]



  before_save :update_priority
  before_destroy :update_priority_before_destroy

  private
  def update_priority
    #self.move_to_bottom
    self.sequence = self.login_account.quick_launch_icons.length+1 if self.new_record?
  end

  def update_priority_before_destroy
    sequence = self.sequence
    QuickLaunchIcon.transaction do
      self.login_account.quick_launch_icons.each { |qli|
        if (qli.sequence > sequence)
          qli.sequence -= 1
          qli.save!
        end
      }
    end
  end

end
