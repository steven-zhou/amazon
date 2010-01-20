class QuickLaunchIcon < ActiveRecord::Base

  belongs_to :login_account, :foreign_key => "login_account_id"

  validates_presence_of :login_account_id


  private
  def update_priority
    #self.move_to_bottom
    self.priority_number = self.login_account.quick_launch_icons.length+1 if self.new_record?
  end

  def update_priority_before_destroy
    priority_number = self.priority_number
    QuickLaunchIcon.transaction do
      self.login_account.quick_launch_icons.each { |qli|
        if (qli.priority_number > priority_number)
          qli.priority_number -= 1
          qli.save!
        end
      }
    end
  end

end
