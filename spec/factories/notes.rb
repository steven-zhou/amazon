Factory.define :note, :class => Note do |f|
  f.sequence(:id) { |n| n }
  f.sequence(:short_description) { |n| "Short Description #{n}" }
  f.sequence(:body_text) { |n| "Body Text #{n}" }
  f.association :noteable, :factory => :john
  f.association :note_type, :factory => :note_type
end

