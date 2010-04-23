class PersonBulkEmail < BulkEmail

  def self.active_record
    @person_bulk_email = PersonBulkEmail.find(:all, :conditions => ["to_be_removed = false"], :order => 'name')
  end
end
