Factory.define :payment_day, :class => PaymentDay do |f|
  f.sequence(:name) { |n| "Every 15th or the month #{n}" }
end