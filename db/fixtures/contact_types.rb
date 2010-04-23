puts "Initializing Contact Type"
ContactMetaMetaType.create :name => "Email",    :status => true, :to_be_removed =>false
ContactMetaMetaType.create :name => "Phone",    :status => true, :to_be_removed =>false
ContactMetaMetaType.create :name => "Website",    :status => true, :to_be_removed =>false
ContactMetaMetaType.create :name => "IM",    :status => true, :to_be_removed =>false

email = ContactMetaMetaType.find_by_name("Email")
phone = ContactMetaMetaType.find_by_name("Phone")
website = ContactMetaMetaType.find_by_name("Website")
im = ContactMetaMetaType.find_by_name("IM")

ContactMetaType.create :name => "Business",   :tag_meta_type_id => email.id,    :status => true, :to_be_removed =>false
ContactMetaType.create :name => "Private",   :tag_meta_type_id => email.id,    :status => true, :to_be_removed =>false
ContactMetaType.create :name => "Hotmail",   :tag_meta_type_id => email.id,    :status => true, :to_be_removed =>false
ContactMetaType.create :name => "Gmail",   :tag_meta_type_id => email.id,    :status => true, :to_be_removed =>false
ContactMetaType.create :name => "Business",   :tag_meta_type_id => phone.id,    :status => true, :to_be_removed =>false
ContactMetaType.create :name => "Pirvate",   :tag_meta_type_id => phone.id,    :status => true, :to_be_removed =>false
ContactMetaType.create :name => "Mobile",   :tag_meta_type_id => phone.id,    :status => true, :to_be_removed =>false
ContactMetaType.create :name => "Fax",   :tag_meta_type_id => phone.id,    :status => true, :to_be_removed =>false
ContactMetaType.create :name => "Business",   :tag_meta_type_id => website.id,    :status => true, :to_be_removed =>false
ContactMetaType.create :name => "Private",   :tag_meta_type_id => website.id,    :status => true, :to_be_removed =>false
ContactMetaType.create :name => "MSN",   :tag_meta_type_id => im.id,    :status => true, :to_be_removed =>false
ContactMetaType.create :name => "Skype",   :tag_meta_type_id => im.id,    :status => true, :to_be_removed =>false
ContactMetaType.create :name => "Facebook",   :tag_meta_type_id => im.id,    :status => true, :to_be_removed =>false
ContactMetaType.create :name => "Twitter",   :tag_meta_type_id => im.id,    :status => true, :to_be_removed =>false
ContactMetaType.create :name => "MySpace",   :tag_meta_type_id => im.id,    :status => true, :to_be_removed =>false


puts "Initializing Receipt Types"
ReceiptMetaMetaType.create :name => "Credit Card",    :status => true, :to_be_removed =>false
ReceiptMetaMetaType.create :name => "Cash",    :status => true, :to_be_removed =>false
ReceiptMetaMetaType.create :name => "Cheque",    :status => true, :to_be_removed =>false


credit_card = ReceiptMetaMetaType.find_by_name("Credit Card")
cash = ReceiptMetaMetaType.find_by_name("Cash")
cheque = ReceiptMetaMetaType.find_by_name("Cheque")


ReceiptMetaType.create :name => "Visa Card",   :tag_meta_type_id => credit_card.id,    :status => true, :to_be_removed =>false
ReceiptMetaType.create :name => "Master Card",   :tag_meta_type_id => credit_card.id,    :status => true, :to_be_removed =>false
ReceiptMetaType.create :name => "Bank Cheque",   :tag_meta_type_id => cheque.id,    :status => true, :to_be_removed =>false
ReceiptMetaType.create :name => "Personal Cheque",   :tag_meta_type_id => cheque.id,    :status => true, :to_be_removed =>false
ReceiptMetaType.create :name => "Cash",   :tag_meta_type_id => cash.id,    :status => true, :to_be_removed =>false


puts "Initializing Payment Methods"
manual = PaymentMethodMetaMetaType.create :name => "Manual", :status => true, :to_be_removed => false
direct_debit = PaymentMethodMetaMetaType.create :name => "Direct Debit", :status => true, :to_be_removed => false

cash = PaymentMethodMetaType.create :name => "Cash", :tag_meta_type_id => manual.id, :status => true, :to_be_removed => false
cheque = PaymentMethodMetaType.create :name => "Cheque", :tag_meta_type_id => manual.id, :status => true, :to_be_removed => false
cc = PaymentMethodMetaType.create :name => "Credit Card", :tag_meta_type_id => manual.id, :status => true, :to_be_removed => false

bank_account = PaymentMethodMetaType.create :name => "Bank Account", :tag_meta_type_id => direct_debit.id, :status => true, :to_be_removed => false
ccd = PaymentMethodMetaType.create :name => "Credit Card", :tag_meta_type_id => direct_debit.id, :status => true, :to_be_removed => false
payroll = PaymentMethodMetaType.create :name => "Payroll Deduction", :tag_meta_type_id => direct_debit.id, :status => true, :to_be_removed => false

PaymentMethodType.create :name => "Cash", :tag_type_id => cash.id, :status => true, :to_be_removed => false
PaymentMethodType.create :name => "Personal Cheque", :tag_type_id => cheque.id, :status => true, :to_be_removed => false
PaymentMethodType.create :name => "Bank Cheque", :tag_type_id => cheque.id, :status => true, :to_be_removed => false
PaymentMethodType.create :name => "Master Card", :tag_type_id => cc.id, :status => true, :to_be_removed => false
PaymentMethodType.create :name => "Visa Card", :tag_type_id => cc.id, :status => true, :to_be_removed => false

PaymentMethodType.create :name => "Saving", :tag_type_id => bank_account.id, :status => true, :to_be_removed => false
PaymentMethodType.create :name => "Cheque", :tag_type_id => bank_account.id, :status => true, :to_be_removed => false
PaymentMethodType.create :name => "Master Card", :tag_type_id => ccd.id, :status => true, :to_be_removed => false
PaymentMethodType.create :name => "Visa Card", :tag_type_id => ccd.id, :status => true, :to_be_removed => false
PaymentMethodType.create :name => "Payroll Deduction", :tag_type_id => payroll.id, :status => true, :to_be_removed => false

puts "Initializing Extra Meta Meta Type"
ExtraMetaMetaType.create(:name => "Custom Field", :status => true,:to_be_removed =>false)

puts "Initailizing Custom Field Group"

ExtraMetaType.create(:name => "Group One",:tag_meta_type_id=>ExtraMetaMetaType.find_by_name("Custom Field").id, :status => true,:to_be_removed =>false)
ExtraMetaType.create(:name => "Group Two",:tag_meta_type_id=>ExtraMetaMetaType.find_by_name("Custom Field").id, :status => true,:to_be_removed =>false)
ExtraMetaType.create(:name => "Group Three",:tag_meta_type_id=>ExtraMetaMetaType.find_by_name("Custom Field").id, :status => true,:to_be_removed =>false)
ExtraMetaType.create(:name => "Group Four",:tag_meta_type_id=>ExtraMetaMetaType.find_by_name("Custom Field").id, :status => true,:to_be_removed =>false)

puts "Initailizing Custom Field Group Lable"
ExtraType.create(:name => "Label One",:tag_type_id=>ExtraMetaType.find_by_name("Group One").id, :status => true,:to_be_removed =>false)
ExtraType.create(:name => "Label Two",:tag_type_id=>ExtraMetaType.find_by_name("Group One").id, :status => true,:to_be_removed =>false)
ExtraType.create(:name => "Label Three",:tag_type_id=>ExtraMetaType.find_by_name("Group One").id, :status => true,:to_be_removed =>false)
ExtraType.create(:name => "Label Four",:tag_type_id=>ExtraMetaType.find_by_name("Group One").id, :status => true,:to_be_removed =>false)
ExtraType.create(:name => "Label Five",:tag_type_id=>ExtraMetaType.find_by_name("Group One").id, :status => true,:to_be_removed =>false)
ExtraType.create(:name => "Label Six",:tag_type_id=>ExtraMetaType.find_by_name("Group One").id, :status => true,:to_be_removed =>false)

ExtraType.create(:name => "Label One",:tag_type_id=>ExtraMetaType.find_by_name("Group Two").id, :status => true,:to_be_removed =>false)
ExtraType.create(:name => "Label Two",:tag_type_id=>ExtraMetaType.find_by_name("Group Two").id, :status => true,:to_be_removed =>false)
ExtraType.create(:name => "Label Three",:tag_type_id=>ExtraMetaType.find_by_name("Group Two").id, :status => true,:to_be_removed =>false)
ExtraType.create(:name => "Label Four",:tag_type_id=>ExtraMetaType.find_by_name("Group Two").id, :status => true,:to_be_removed =>false)
ExtraType.create(:name => "Label Five",:tag_type_id=>ExtraMetaType.find_by_name("Group Two").id, :status => true,:to_be_removed =>false)
ExtraType.create(:name => "Label Six",:tag_type_id=>ExtraMetaType.find_by_name("Group Two").id, :status => true,:to_be_removed =>false)

ExtraType.create(:name => "Label One",:tag_type_id=>ExtraMetaType.find_by_name("Group Three").id, :status => true,:to_be_removed =>false)
ExtraType.create(:name => "Label Two",:tag_type_id=>ExtraMetaType.find_by_name("Group Three").id, :status => true,:to_be_removed =>false)
ExtraType.create(:name => "Label Three",:tag_type_id=>ExtraMetaType.find_by_name("Group Three").id, :status => true,:to_be_removed =>false)
ExtraType.create(:name => "Label Four",:tag_type_id=>ExtraMetaType.find_by_name("Group Three").id, :status => true,:to_be_removed =>false)
ExtraType.create(:name => "Label Five",:tag_type_id=>ExtraMetaType.find_by_name("Group Three").id, :status => true,:to_be_removed =>false)
ExtraType.create(:name => "Label Six",:tag_type_id=>ExtraMetaType.find_by_name("Group Three").id, :status => true,:to_be_removed =>false)

ExtraType.create(:name => "Label One",:tag_type_id=>ExtraMetaType.find_by_name("Group Four").id, :status => true,:to_be_removed =>false)
ExtraType.create(:name => "Label Two",:tag_type_id=>ExtraMetaType.find_by_name("Group Four").id, :status => true,:to_be_removed =>false)
ExtraType.create(:name => "Label Three",:tag_type_id=>ExtraMetaType.find_by_name("Group Four").id, :status => true,:to_be_removed =>false)
ExtraType.create(:name => "Label Four",:tag_type_id=>ExtraMetaType.find_by_name("Group Four").id, :status => true,:to_be_removed =>false)
ExtraType.create(:name => "Label Five",:tag_type_id=>ExtraMetaType.find_by_name("Group Four").id, :status => true,:to_be_removed =>false)
ExtraType.create(:name => "Label Six",:tag_type_id=>ExtraMetaType.find_by_name("Group Four").id, :status => true,:to_be_removed =>false)