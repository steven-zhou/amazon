Factory.define :master_doc do |f|
  f.sequence(:id) { |n| n }
  f.sequence(:priority_number) { |n| n }
  f.sequence(:doc_number) { |n| "doc_number_#{n}"}
  f.sequence(:doc_reference) { |n| "ref_#{n}"}
  f.sequence(:security_number) { |n| "#{n}"}
  f.sequence(:category) { |n| "category_#{n}"}
  f.sequence(:long_name) { |n| "long_name_#{n}"}
  f.sequence(:short_name) { |n| "s_#{n}"}
  f.sequence(:name_on_doc) { |n| "name_on_doc_#{n}"}
  f.sequence(:other_on_doc) { |n| "other_on_doc_#{n}"}
  f.sequence(:issue_person) { |n| "issue_person_#{n}"}
  f.sequence(:issue_organisation) { |n| "issue_organisation_#{n}"}
  f.sequence(:issue_place) { |n| "issue_place_#{n}"}
  f.sequence(:issue_state) { |n| "issue_state_#{n}"}
  f.sequence(:action_taken) { |n| "action_taken_#{n}"}
  f.sequence(:remarks) { |n| "remarks_#{n}"}
  f.issue_date Date.today
  f.expiry_date Date.today
  f.reminder true
  f.association :master_doc_type, :factory => :master_doc_type
  f.association :entity, :factory => :john
  f.association :issue_country_id, :factory => :australia

end