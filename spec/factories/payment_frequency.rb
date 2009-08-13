Factory.define :payment_frequency, :class => PaymentFrequency do |f|
  f.sequence(:name) { |n| "Weekly #{n}" }
end