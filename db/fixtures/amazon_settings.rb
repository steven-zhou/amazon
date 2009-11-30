puts "Initializing Amazon Setting"
Title.create :name => "Mr", :status => true
Title.create :name => "Mrs", :status => true
Title.create :name => "Ms", :status => true
Title.create :name => "Dr", :status => true
Title.create :name => "Professor", :status => true
Gender.create :name => "Male", :status => true
Gender.create :name => "Female", :status => true
Religion.create :name => "Christianity", :status => true
Religion.create :name => "Judaism", :status => true
Religion.create :name => "Hinduism", :status => true
Religion.create :name => "Buddhism", :status => true
Religion.create :name => "Islam", :status => true
Religion.create :name => "Jainism", :status => true
Language.create :name => "English", :status => true
Language.create :name => "French", :status => true
Language.create :name => "Spanish", :status => true
Language.create :name => "Italian", :status => true
Language.create :name => "Hindi", :status => true
Language.create :name => "Arabic", :status => true
Language.create :name => "Chinese", :status => true
IndustrySector.create :name => "Goverment", :description => "1", :status => true
IndustrySector.create :name => "Private", :description => "2", :status => true
AddressType.create :name => "Home", :status => true
AddressType.create :name => "Business", :status => true
AddressType.create :name => "Mail", :status => true
AddressType.create :name => "Holiday", :status => true
AddressType.create :name => "Overseas", :status => true
NoteType.create :name => "Business", :status => true
NoteType.create :name => "Personal", :status => true
NoteType.create :name => "ToDo", :status => true
NoteType.create :name => "History", :status => true
NoteType.create :name => "Membership", :status => true
NoteType.create :name => "Payments", :status => true
KeywordType.create :name => "Business", :status => true
KeywordType.create :name => "Personal", :status => true
KeywordType.create :name => "Search", :status => true
KeywordType.create :name => "Notes", :status => true
KeywordType.create :name => "Mailing", :status => true
KeywordType.create :name => "Industrial", :status => true
KeywordType.create :name => "2009", :status => true
RoleType.create :name => "Management", :status => true
RoleType.create :name => "Supervisor", :status => true
RoleType.create :name => "Operational", :status => true
RoleType.create :name => "Marketing", :status => true
RoleType.create :name => "Planning", :status => true
RelationshipType.create :name => "Father", :status => true
RelationshipType.create :name => "Mother", :status => true
RelationshipType.create :name => "Spouse", :status => true
RelationshipType.create :name => "Next of Kin", :status => true
MaritalStatus.create :name => "Single", :status => true
MaritalStatus.create :name => "Married", :status => true
MaritalStatus.create :name => "Divorced", :status => true
MaritalStatus.create :name => "Engaged", :status => true
MaritalStatus.create :name => "Separated", :status => true
MaritalStatus.create :name => "Widowed", :status => true
MaritalStatus.create :name => "De Facto", :status => true
Department.create :name => "Research and Development", :status => true
Department.create :name => "Sales", :status => true
Section.create :name => "Development", :status => true
Section.create :name => "Maintaince", :status => true
CostCentre.create :name => "Research and Development", :status => true
CostCentre.create :name => "Customer Service", :status => true
PositionTitle.create :name => "Developer", :status => true
PositionTitle.create :name => "Saler", :status => true
PositionClassification.create :name => "Management", :status => true
PositionClassification.create :name => "Operation", :status => true
PositionClassification.create :name => "Admin", :status => true
PositionType.create :name => "Permanent", :status => true
PositionType.create :name => "Temporary", :status => true
PositionType.create :name => "Fixed Term", :status => true
AwardAgreement.create :name => "Annual Plus", :status => true
PositionStatus.create :name => "Full-time", :status => true
PositionStatus.create :name => "Part-time", :status => true
PaymentFrequency.create :name => "Weekly", :status => true
PaymentFrequency.create :name => "Fortnightly", :status => true
PaymentFrequency.create :name => "Monthly", :status => true
PaymentMethod.create :name => "Cheque", :status => true
PaymentMethod.create :name => "Cash", :status => true
PaymentMethod.create :name => "Bank Transfer", :status => true
PaymentDay.create :name => "Every 15th of the month", :status => true
SuspensionType.create :name => "Pending case", :status => true
SuspensionType.create :name => "Stepped down", :status => true
SuspensionType.create :name => "Investigation", :status => true
TerminationMethod.create :name => "By consent", :status => true
TerminationMethod.create :name => "By notice", :status => true
OrganisationType.create :name => "Public", :status => true
OrganisationType.create :name => "Pty Ltd", :status => true
SecurityQuestion.create :name => "what is your favorite pet name", :status => true
SecurityQuestion.create :name => "what is your father's name", :status => true
SecurityQuestion.create :name => "what is your mather's name", :status => true
BusinessCategory.create :name => "Sales", :description => "10", :status => true
BusinessCategory.create :name => "Wholesaler", :description => "11", :status => true
BusinessCategory.create :name => "Service", :description => "12", :status => true
ReceiptAccountType.create(:name => "Membership")
ReceiptAccountType.create(:name => "Donation")
ReceiptAccountType.create(:name => "Sundry")
ReceiptAccountType.create(:name => "Miscellaneous")
ReceiptMethodType.create(:name => "Cash")
ReceiptMethodType.create(:name => "Cheque")
ReceiptMethodType.create(:name => "Money Order")
ReceiptMethodType.create(:name => "Credit Card")
ReceiptMethodType.create(:name => "Direct Credit")
ReceiptMethodType.create(:name => "Direct Debit")
ReceiptMethodType.create(:name => "Credit Journal")
ReceiptMethodType.create(:name => "Debit Journal")
AccountPurpose.create(:name => "Payroll")
AccountPurpose.create(:name => "Donation")
AccountPurpose.create(:name => "Membership Fees")
AccountPurpose.create(:name => "General")
AccountType.create(:name => "Savings")
AccountType.create(:name => "Cheque")