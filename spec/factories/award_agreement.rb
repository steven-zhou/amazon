Factory.define :award_agreement, :class => AwardAgreement do |f|
  f.sequence(:name) { |n| "Annual Plus #{n}" }
end