class CreateExtraTypes < ActiveRecord::Migration
  def self.up
    create_table :extra_types do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :extra_types
  end
end
