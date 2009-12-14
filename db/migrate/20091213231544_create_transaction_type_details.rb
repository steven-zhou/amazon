class CreateTransactionTypeDetails < ActiveRecord::Migration
  def self.up
    create_table :transaction_type_details do |t|
      t.column :transaction_header_id, :integer
      t.column :type, :string #Cheque/Credit Card

      #Cheque Fields
      t.column :bank_name, :string
      t.column :bsb, :string
      t.column :name_on_cheque, :string
      t.column :cheque_number, :string
      t.column :date_on_cheque, :string

      #Credit Card Fields
      t.column :name_on_card, :string
      t.column :card_number, :string
      t.column :expire_month, :string
      t.column :expire_year, :string
      t.column :cvv_number, :string
      t.timestamps

    end
  end

  def self.down
    drop_table :transaction_type_details
  end
end
