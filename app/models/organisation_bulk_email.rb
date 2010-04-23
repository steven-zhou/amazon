class OrganisationBulkEmail < BulkEmail
    def self.active_record
    @organisation_bulk_email = OrganisationBulkEmail.find(:all, :conditions => ["to_be_removed = false"], :order => 'name')
  end
end
