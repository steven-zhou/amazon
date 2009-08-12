Factory.define :note_type, :class => NoteType do |f|
  f.sequence(:id) { |n| n }
  f.sequence(:name) { |n| "Name #{n}" }
end

