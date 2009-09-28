class CreateDuplicationFormulas < ActiveRecord::Migration
  def self.up
    create_table :duplication_formulas do |t|
      t.string :duplication_space
      t.string :description
      t.timestamps
    end
  end

  def self.down
    drop_table :duplication_formulas
  end
end
