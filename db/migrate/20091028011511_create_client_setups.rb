class CreateClientSetups < ActiveRecord::Migration
  def self.up
    create_table :client_setups do |t|
      t.column :organisation_id, :integer
      t.column :client_id, :string
      t.column :client_rego, :string
      t.column :installation_date, :date
      t.column :halt_date, :date
      t.column :system_status, :boolean
      t.column :modules_installed, :string
      t.column :system_type, :string
      t.column :system_purchase, :string
      t.column :maximum_core_records, :integer
      t.column :hosting_status, :string
      t.column :number_of_users, :integer
      t.column :message_to_super_admin, :string
      t.column :number_of_login_attempts, :integer
      t.column :new_account_graceperiod, :integer
      t.column :session_timeout, :integer
      t.column :passward_lifetime, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :client_setups
  end
end
