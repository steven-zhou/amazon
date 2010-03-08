class ChangeGlCodeToLowercase < ActiveRecord::Migration
  def self.up
    rename_column :fee_items, :GL_Code, :gl_code
  end

  def self.down
    rename_column :fee_items, :gl_code, :GL_Code
  end
end
