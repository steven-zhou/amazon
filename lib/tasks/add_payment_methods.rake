namespace :db do
  desc "Add new payment methods"
  task :add_payment_methods => :environment do
    puts "Run Patch Add all payment methods ..."
    manual = PaymentMethodMetaType.create :name => "Manual", :status => true, :to_be_removed => false
    direct_debit = PaymentMethodMetaType.create :name => "Direct Debit", :status => true, :to_be_removed => false

    cash = PaymentMethodType.create :name => "Cash", :tag_meta_type_id => manual.id, :status => true, :to_be_removed => false
    cheque = PaymentMethodType.create :name => "Cheque", :tag_meta_type_id => manual.id, :status => true, :to_be_removed => false
    cc = PaymentMethodType.create :name => "Credit Card", :tag_meta_type_id => manual.id, :status => true, :to_be_removed => false

    bank_account = PaymentMethodType.create :name => "Bank Account", :tag_meta_type_id => direct_debit.id, :status => true, :to_be_removed => false
    ccd = PaymentMethodType.create :name => "Credit Card", :tag_meta_type_id => direct_debit.id, :status => true, :to_be_removed => false
    payroll = PaymentMethodType.create :name => "Payroll Deduction", :tag_meta_type_id => direct_debit.id, :status => true, :to_be_removed => false

    PaymentMethod.create :name => "Cash", :tag_type_id => cash.id, :status => true, :to_be_removed => false
    PaymentMethod.create :name => "Personal Cheque", :tag_type_id => cheque.id, :status => true, :to_be_removed => false
    PaymentMethod.create :name => "Bank Cheque", :tag_type_id => cheque.id, :status => true, :to_be_removed => false
    PaymentMethod.create :name => "Master Card", :tag_type_id => cc.id, :status => true, :to_be_removed => false
    PaymentMethod.create :name => "Visa Card", :tag_type_id => cc.id, :status => true, :to_be_removed => false

    PaymentMethod.create :name => "Saving", :tag_type_id => bank_account.id, :status => true, :to_be_removed => false
    PaymentMethod.create :name => "Cheque", :tag_type_id => bank_account.id, :status => true, :to_be_removed => false
    PaymentMethod.create :name => "Master Card", :tag_type_id => ccd.id, :status => true, :to_be_removed => false
    PaymentMethod.create :name => "Visa Card", :tag_type_id => ccd.id, :status => true, :to_be_removed => false
    PaymentMethod.create :name => "Payroll Deduction", :tag_type_id => payroll.id, :status => true, :to_be_removed => false
    puts "DONE"
  end
end
