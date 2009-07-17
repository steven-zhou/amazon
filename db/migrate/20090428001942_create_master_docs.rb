class CreateMasterDocs < ActiveRecord::Migration
  def self.up
    create_table :master_docs do |t|
      t.string :doc_number,:doc_reference, :security_number,:category,:long_name,:short_name,:name_on_doc,:other_on_doc
      t.string :issue_person,:issue_organisation,:issue_place,:issue_state,:issue_country,:action_taken,:remarks
      t.date :issue_date,:expiry_date
      t.boolean :reminder
      t.references :master_doc_type
      t.references :entity, :polymorphic => true
      t.timestamps
    end
  end

  def self.down
    drop_table :master_docs
  end
end
