Factory.define :search_engine, :class => BusinessCategory do |f|
  f.sequence(:name) { |n| "Search Engine #{n}" }
end