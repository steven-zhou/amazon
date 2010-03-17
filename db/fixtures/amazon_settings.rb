puts "Initializing Amazon Setting"
Title.create :name => "Mr", :status => true,:to_be_removed =>false
Title.create :name => "Mrs", :status => true,:to_be_removed =>false
Title.create :name => "Ms", :status => true,:to_be_removed =>false
Title.create :name => "Dr", :status => true,:to_be_removed =>false
Title.create :name => "Professor", :status => true,:to_be_removed =>false
Gender.create :name => "Male", :status => true,:to_be_removed =>false
Gender.create :name => "Female", :status => true,:to_be_removed =>false
Religion.create :name => "Christianity", :status => true,:to_be_removed =>false
Religion.create :name => "Judaism", :status => true,:to_be_removed =>false
Religion.create :name => "Hinduism", :status => true,:to_be_removed =>false
Religion.create :name => "Buddhism", :status => true,:to_be_removed =>false
Religion.create :name => "Islam", :status => true,:to_be_removed =>false
Religion.create :name => "Jainism", :status => true,:to_be_removed =>false
Language.create :name => "English", :status => true,:to_be_removed =>false
Language.create :name => "French", :status => true,:to_be_removed =>false
Language.create :name => "Spanish", :status => true,:to_be_removed =>false
Language.create :name => "Italian", :status => true,:to_be_removed =>false
Language.create :name => "Hindi", :status => true,:to_be_removed =>false
Language.create :name => "Arabic", :status => true,:to_be_removed =>false
Language.create :name => "Chinese", :status => true,:to_be_removed =>false
IndustrySector.create :name => "Goverment", :description => "1", :status => true,:to_be_removed =>false
IndustrySector.create :name => "Private", :description => "2", :status => true,:to_be_removed =>false
AddressType.create :name => "Home", :status => true,:to_be_removed =>false
AddressType.create :name => "Business", :status => true,:to_be_removed =>false
AddressType.create :name => "Mail", :status => true,:to_be_removed =>false
AddressType.create :name => "Holiday", :status => true,:to_be_removed =>false
AddressType.create :name => "Overseas", :status => true,:to_be_removed =>false
NoteType.create :name => "Business", :status => true,:to_be_removed =>false
NoteType.create :name => "Personal", :status => true,:to_be_removed =>false
NoteType.create :name => "ToDo", :status => true,:to_be_removed =>false
NoteType.create :name => "History", :status => true,:to_be_removed =>false
NoteType.create :name => "Membership", :status => true,:to_be_removed =>false
NoteType.create :name => "Payments", :status => true,:to_be_removed =>false
KeywordType.create :name => "Business", :status => true,:to_be_removed =>false
KeywordType.create :name => "Personal", :status => true,:to_be_removed =>false
KeywordType.create :name => "Search", :status => true,:to_be_removed =>false
KeywordType.create :name => "Notes", :status => true,:to_be_removed =>false
KeywordType.create :name => "Mailing", :status => true,:to_be_removed =>false
KeywordType.create :name => "Industrial", :status => true,:to_be_removed =>false
KeywordType.create :name => "2009", :status => true,:to_be_removed =>false
RoleType.create :name => "Management", :status => true,:to_be_removed =>false
RoleType.create :name => "Supervisor", :status => true,:to_be_removed =>false
RoleType.create :name => "Operational", :status => true,:to_be_removed =>false
RoleType.create :name => "Marketing", :status => true,:to_be_removed =>false
RoleType.create :name => "Planning", :status => true,:to_be_removed =>false
RelationshipType.create :name => "Father", :status => true,:to_be_removed =>false
RelationshipType.create :name => "Mother", :status => true,:to_be_removed =>false
RelationshipType.create :name => "Spouse", :status => true,:to_be_removed =>false
RelationshipType.create :name => "Next of Kin", :status => true,:to_be_removed =>false
MaritalStatus.create :name => "Single", :status => true,:to_be_removed =>false
MaritalStatus.create :name => "Married", :status => true,:to_be_removed =>false
MaritalStatus.create :name => "Divorced", :status => true,:to_be_removed =>false
MaritalStatus.create :name => "Engaged", :status => true,:to_be_removed =>false
MaritalStatus.create :name => "Separated", :status => true,:to_be_removed =>false
MaritalStatus.create :name => "Widowed", :status => true,:to_be_removed =>false
MaritalStatus.create :name => "De Facto", :status => true,:to_be_removed =>false
Department.create :name => "Research and Development", :status => true,:to_be_removed =>false
Department.create :name => "Sales", :status => true,:to_be_removed =>false
Section.create :name => "Development", :status => true,:to_be_removed =>false
Section.create :name => "Maintaince", :status => true,:to_be_removed =>false
CostCentre.create :name => "Research and Development", :status => true,:to_be_removed =>false
CostCentre.create :name => "Customer Service", :status => true,:to_be_removed =>false
PositionTitle.create :name => "Developer", :status => true,:to_be_removed =>false
PositionTitle.create :name => "Saler", :status => true,:to_be_removed =>false
PositionClassification.create :name => "Management", :status => true,:to_be_removed =>false
PositionClassification.create :name => "Operation", :status => true,:to_be_removed =>false
PositionClassification.create :name => "Admin", :status => true,:to_be_removed =>false
PositionType.create :name => "Permanent", :status => true,:to_be_removed =>false
PositionType.create :name => "Temporary", :status => true,:to_be_removed =>false
PositionType.create :name => "Fixed Term", :status => true,:to_be_removed =>false
AwardAgreement.create :name => "Annual Plus", :status => true,:to_be_removed =>false
PositionStatus.create :name => "Full-time", :status => true,:to_be_removed =>false
PositionStatus.create :name => "Part-time", :status => true,:to_be_removed =>false
PaymentFrequency.create :name => "Weekly", :status => true,:to_be_removed =>false
PaymentFrequency.create :name => "Fortnightly", :status => true,:to_be_removed =>false
PaymentFrequency.create :name => "Monthly", :status => true,:to_be_removed =>false
PayrollMethod.create :name => "Cheque", :status => true,:to_be_removed =>false
PayrollMethod.create :name => "Cash", :status => true,:to_be_removed =>false
PayrollMethod.create :name => "Bank Transfer", :status => true,:to_be_removed =>false
PaymentDay.create :name => "Every 15th of the month", :status => true,:to_be_removed =>false
SuspensionType.create :name => "Pending case", :status => true,:to_be_removed =>false
SuspensionType.create :name => "Stepped down", :status => true,:to_be_removed =>false
SuspensionType.create :name => "Investigation", :status => true,:to_be_removed =>false
TerminationMethod.create :name => "By consent", :status => true,:to_be_removed =>false
TerminationMethod.create :name => "By notice", :status => true,:to_be_removed =>false
OrganisationType.create :name => "Public", :status => true,:to_be_removed =>false
OrganisationType.create :name => "Pty Ltd", :status => true,:to_be_removed =>false
SecurityQuestion.create :name => "What is your favorite pet's name?", :status => true,:to_be_removed =>false
SecurityQuestion.create :name => "What is your father's name?", :status => true,:to_be_removed =>false
SecurityQuestion.create :name => "What is your mother's name?", :status => true,:to_be_removed =>false
BusinessCategory.create :name => "Sales", :description => "10", :status => true,:to_be_removed =>false
BusinessCategory.create :name => "Wholesaler", :description => "11", :status => true,:to_be_removed =>false
BusinessCategory.create :name => "Service", :description => "12", :status => true,:to_be_removed =>false
ReceiptAccountType.create(:name => "Membership", :status => true,:to_be_removed =>false)
ReceiptAccountType.create(:name => "Donation", :status => true,:to_be_removed =>false)
ReceiptAccountType.create(:name => "Sundry", :status => true,:to_be_removed =>false)
ReceiptAccountType.create(:name => "Miscellaneous", :status => true,:to_be_removed =>false)
AccountPurpose.create(:name => "Payroll", :status => true,:to_be_removed =>false)
AccountPurpose.create(:name => "Donation", :status => true,:to_be_removed =>false)
AccountPurpose.create(:name => "Membership Fees", :status => true,:to_be_removed =>false)
AccountPurpose.create(:name => "General", :status => true,:to_be_removed =>false)
AccountType.create(:name => "Savings", :status => true,:to_be_removed =>false)
AccountType.create(:name => "Cheque", :status => true,:to_be_removed =>false)
LinkModule.create(:name => "Membership", :status => true,:to_be_removed =>false)
LinkModule.create(:name => "Donation", :status => true,:to_be_removed =>false)
LinkModule.create(:name => "Sundry", :status => true,:to_be_removed =>false)
LinkModule.create(:name => "Miscellaneous", :status => true,:to_be_removed =>false)
ReceivedVia.create(:name => "Phone", :status => true,:to_be_removed =>false)
ReceivedVia.create(:name => "Internet", :status => true,:to_be_removed =>false)
ReceivedVia.create(:name => "Fax", :status => true,:to_be_removed =>false)
TemplateCategory.create(:name => "Others", :status => true,:to_be_removed =>false, :description => "can not be deleted")
TemplateCategory.create(:name => "Membership", :status => true,:to_be_removed =>false)
MembershipType.create(:name => "Full Member", :status => true,:to_be_removed =>false)
MembershipStatus.create(:name => "Prospective", :status => true,:to_be_removed =>false)
MembershipStatus.create(:name => "In-review", :status => true,:to_be_removed =>false)
MembershipStatus.create(:name => "Rejected", :status => true,:to_be_removed =>false)
MembershipStatus.create(:name => "Active", :status => true,:to_be_removed =>false)
MembershipStatus.create(:name => "Suspended", :status => true,:to_be_removed =>false)
MembershipStatus.create(:name => "Terminated", :status => true,:to_be_removed =>false)
MembershipStatus.create(:name => "Archived", :status => true,:to_be_removed =>false)
MembershipStatus.create(:name => "Removed", :status => true,:to_be_removed =>false)
ExtraMetaMetaType.create(:name => "Extra", :status => true,:to_be_removed =>false)