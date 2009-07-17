Factory.define :keyword do |f|
  f.sequence(:name) {|n| "keyword#{n}" }
  f.association :keyword_type, :factory => :keyword_type
end