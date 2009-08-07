Factory.define :language do |f|
  f.sequence(:name) { |n| "Language #{n}" }
end