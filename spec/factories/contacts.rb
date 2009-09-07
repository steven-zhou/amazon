Factory.define :contact do |f|
  f.pre_value "00"
  f.value "111111"
  f.post_value "ext 111"
  f.preferred_time "time"
  f.preferred_day "Day"
  f.remarks "Remarks"

  f.association :contactable, :factory => :john
end