class BulkEmail < ActiveRecord::Base
  
  def current_status
    if self.to_be_removed
      "To Be Removed"
    elsif self.status && !self.dispatch_date.nil?
      "Sent"
    elsif self.status && self.dispatch_date.nil?
      "Queued"
    elsif !self.status
      "On Hold"
    end

  end

end
