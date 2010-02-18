class MailLog < ActiveRecord::Base


  belongs_to :entity, :polymorphic => true

  belongs_to :person_mail_template, :class_name => "PersonMailTemplate", :foreign_key => "doc_id"
  belongs_to :organisation_mail_template, :class_name => "OrganisationMailTemplate", :foreign_key => "doc_id"
end
