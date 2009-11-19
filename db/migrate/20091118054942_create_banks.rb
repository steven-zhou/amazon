class CreateBanks < ActiveRecord::Migration
  def self.up
    create_table :banks do |t|
      t.column :full_name, :text
      t.column :short_name, :text
      t.column :branch_name, :text
      t.column :branch_number, :text
      t.column :address_line_1, :text
      t.column :address_line_2, :text
      t.column :address_line_3, :text
      t.column :state, :text
      t.column :postcode, :text
      t.column :country_id, :integer
      t.column :website, :text
      t.column :general_email, :text
      t.column :contact_person, :text
      t.column :contact_person_job_title, :text
      t.column :contact_person_email, :text
      t.column :contact_phone, :text
      t.column :contact_fax, :text
      t.column :contact_mobile, :text
      t.column :status, :boolean
      t.column :status_reason, :text
      t.column :remarks, :text
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
  end

  def self.down
    drop_table :banks
  end
end
