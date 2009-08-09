Factory.define :buddhism, :class => Religion do |f|
  f.sequence(:id) { |n| n }
  f.sequence(:priority_number) { |n| n }
  f.name "Buddhism"
end

