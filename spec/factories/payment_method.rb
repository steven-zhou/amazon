Factory.define :payment_method, :class => PaymentMethod do |f|
  f.sequence(:name) { |n| "Cash #{n}" }
end