class CreateExtraMetaMetaTypes < ActiveRecord::Migration
  def self.up
    create_table :extra_meta_meta_types do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :extra_meta_meta_types
  end
end
