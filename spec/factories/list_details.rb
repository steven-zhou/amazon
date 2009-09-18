Factory.define :list_detail do |f|
  f.association :list_header, :factory => :list_header
  f.association :person, :factory => :john
end

Factory.define :lsit_detail1 do |f|
  f.association :list_header, :factory => :list_header
  f.association :person, :factory => :jane
end
