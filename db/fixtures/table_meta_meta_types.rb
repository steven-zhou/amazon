puts "Initializing Query Tables"
people = TableMetaMetaType.create :name => "people", :description => "people table", :status => true, :category => "person", :to_be_removed =>false
TableMetaType.create :name => "custom_id", :tag_meta_type_id => people.id, :description => "Custom ID (e.g. 100)",  :status => true, :category => "Integer", :to_be_removed =>false
TableMetaType.create :name => "first_name", :tag_meta_type_id => people.id, :description => "First Name (e.g. Jane)",  :status => true, :category => "String", :to_be_removed =>false
TableMetaType.create :name => "middle_name", :tag_meta_type_id => people.id, :description => "Middle Name (e.g. Mary)",  :status => true, :category => "String", :to_be_removed =>false
TableMetaType.create :name => "family_name", :tag_meta_type_id => people.id, :description => "Family Name (e.g. Smith)",  :status => true, :category => "String", :to_be_removed =>false
TableMetaType.create :name => "maiden_name", :tag_meta_type_id => people.id, :description => "Maiden Name (e.g. Bush)",  :status => true, :category => "String", :to_be_removed =>false
TableMetaType.create :name => "preferred_name", :tag_meta_type_id => people.id, :description => "Preferred Name (e.g. Jo)",  :status => true, :category => "String", :to_be_removed =>false
TableMetaType.create :name => "initials", :tag_meta_type_id => people.id, :description => "Initials (e.g. Jo)",  :status => true, :category => "String", :to_be_removed =>false
TableMetaType.create :name => "post_title", :tag_meta_type_id => people.id, :description => "Post Title (e.g. Jane Smith)",  :status => true, :category => "String", :to_be_removed =>false
TableMetaType.create :name => "birth_date", :tag_meta_type_id => people.id, :description => "Date of Birth (dd-mm-yyyy e.g. 01-11-2000)",  :status => true, :category => "Date", :to_be_removed =>false
TableMetaType.create :name => "primary_salutation", :tag_meta_type_id => people.id, :description => "Primary Salutation (e.g. Jane Smith)",  :status => true, :category => "String", :to_be_removed =>false
TableMetaType.create :name => "second_salutation", :tag_meta_type_id => people.id, :description => "Second Salutation (e.g. Jane Smith)",  :status => true, :category => "String", :to_be_removed =>false
TableMetaType.create :name => "industry_sector", :tag_meta_type_id => people.id, :description => "Industry Sector (e.g. IT)",  :status => true, :category => "Integer FK", :to_be_removed =>false
TableMetaType.create :name => "interests", :tag_meta_type_id => people.id, :description => "Interests (e.g. Cricket)",  :status => true, :category => "String", :to_be_removed =>false
TableMetaType.create :name => "language", :tag_meta_type_id => people.id, :description => "Language (e.g. English)",  :status => true, :category => "Integer FK", :to_be_removed =>false
TableMetaType.create :name => "religion", :tag_meta_type_id => people.id, :description => "Religion (e.g. Christianity)",  :status => true, :category => "Integer FK", :to_be_removed =>false
TableMetaType.create :name => "onrecord_since", :tag_meta_type_id => people.id, :description => "Onrecord Since (dd-mm-yyyy e.g. 01-11-2000)",  :status => true, :category => "Date", :to_be_removed =>false
TableMetaType.create :name => "marital_status", :tag_meta_type_id => people.id, :description => "Marital Status (e.g. Single)",  :status => true, :category => "Integer FK", :to_be_removed =>false
TableMetaType.create :name => "gender", :tag_meta_type_id => people.id, :description => "Gender (e.g. Female)",  :status => true, :category => "Integer FK", :to_be_removed =>false


#Employments Table
employments = TableMetaMetaType.create :name => "employments", :description => "employments table", :status => true, :category => "person", :to_be_removed =>false
TableMetaType.create :name => "position_name", :tag_meta_type_id => employments.id, :description => "Position (e.g. Developer)",  :status => true, :category => "String", :to_be_removed =>false
TableMetaType.create :name => "duties_resposibilities", :tag_meta_type_id => employments.id, :description => "Duty/Resposibility (e.g. Project Estimation)",  :status => true, :category => "String", :to_be_removed =>false
TableMetaType.create :name => "annual_base_salary", :tag_meta_type_id => employments.id, :description => "Annual Salary (e.g. 50000)",  :status => true, :category => "Float", :to_be_removed =>false
TableMetaType.create :name => "department", :tag_meta_type_id => employments.id, :description => "Department (e.g. R&D)",  :status => true, :category => "Integer FK", :to_be_removed =>false
TableMetaType.create :name => "section", :tag_meta_type_id => employments.id, :description => "Sectiion (e.g. IT)",  :status => true, :category => "Integer FK", :to_be_removed =>false
TableMetaType.create :name => "position_title", :tag_meta_type_id => employments.id, :description => "Position Description (e.g. Developer)",  :status => true, :category => "Integer FK", :to_be_removed =>false
TableMetaType.create :name => "position_classification", :tag_meta_type_id => employments.id, :description => "Position Classification (e.g. Developer)",  :status => true, :category => "Integer FK", :to_be_removed =>false
TableMetaType.create :name => "position_type", :tag_meta_type_id => employments.id, :description => "Position Type (e.g. Permanent)",  :status => true, :category => "Integer FK", :to_be_removed =>false
TableMetaType.create :name => "position_status", :tag_meta_type_id => employments.id, :description => "Position Status (e.g. Full-time)",  :status => true, :category => "Integer FK", :to_be_removed =>false


#Organisations Table
organisations = TableMetaMetaType.create :name => "organisations", :description => "organisations table", :status => true, :category => "organisation", :to_be_removed =>false
TableMetaType.create :name => "custom_id", :tag_meta_type_id => organisations.id, :description => "Custom ID (e.g. 100)",  :status => true, :category => "String", :to_be_removed =>false
TableMetaType.create :name => "full_name", :tag_meta_type_id => organisations.id, :description => "Full Name (e.g. Google Pty Ltd)",  :status => true, :category => "String", :to_be_removed =>false
TableMetaType.create :name => "short_name", :tag_meta_type_id => organisations.id, :description => "Short Name (e.g. Google)",  :status => true, :category => "String", :to_be_removed =>false
TableMetaType.create :name => "trading_as", :tag_meta_type_id => organisations.id, :description => "Trading As (e.g. Google)",  :status => true, :category => "String", :to_be_removed =>false
TableMetaType.create :name => "registered_name", :tag_meta_type_id => organisations.id, :description => "Registered Name (e.g. Google)",  :status => true, :category => "String", :to_be_removed =>false
TableMetaType.create :name => "registered_number", :tag_meta_type_id => organisations.id, :description => "Registered Number (e.g. 8373837684734)",  :status => true, :category => "String", :to_be_removed =>false
TableMetaType.create :name => "registered_date", :tag_meta_type_id => organisations.id, :description => "Registered Date (dd-mm-yyyy e.g. 01-11-2000)",  :status => true, :category => "Date", :to_be_removed =>false
TableMetaType.create :name => "registered_country", :tag_meta_type_id => organisations.id, :description => "Registered Country (e.g. Australia)",  :status => true, :category => "Integer FK", :to_be_removed =>false
TableMetaType.create :name => "tax_file_no", :tag_meta_type_id => organisations.id, :description => "Tax File Number (e.g. 863782773)",  :status => true, :category => "String", :to_be_removed =>false
TableMetaType.create :name => "legal_no_1", :tag_meta_type_id => organisations.id, :description => "Legal Number 1 (e.g. 93884f9d)",  :status => true, :category => "String", :to_be_removed =>false
TableMetaType.create :name => "legal_no_2", :tag_meta_type_id => organisations.id, :description => "Legal Number 2 (e.g. 93884f9d)",  :status => true, :category => "String", :to_be_removed =>false
TableMetaType.create :name => "industrial_code", :tag_meta_type_id => organisations.id, :description => "Industry Code (e.g. iso.123)",  :status => true, :category => "String", :to_be_removed =>false
TableMetaType.create :name => "number_of_full_time_employees", :tag_meta_type_id => organisations.id, :description => "Number of Full-time Employees (e.g. 3000)",  :status => true, :category => "Integer", :to_be_removed =>false
TableMetaType.create :name => "number_of_part_time_employees", :tag_meta_type_id => organisations.id, :description => "Number of Part-time Employees (e.g. 1000)",  :status => true, :category => "Integer", :to_be_removed =>false
TableMetaType.create :name => "number_of_contractors", :tag_meta_type_id => organisations.id, :description => "Number of Contractors (e.g. 1000)",  :status => true, :category => "Integer", :to_be_removed =>false
TableMetaType.create :name => "number_of_volunteers", :tag_meta_type_id => organisations.id, :description => "Number of Volunteers (e.g. 200)",  :status => true, :category => "Integer", :to_be_removed =>false
TableMetaType.create :name => "number_of_other_workers", :tag_meta_type_id => organisations.id, :description => "Number of Other Workers (e.g. 100)",  :status => true, :category => "Integer", :to_be_removed =>false
TableMetaType.create :name => "business_mission", :tag_meta_type_id => organisations.id, :description => "Business Mission (e.g. Conquer the world)",  :status => true, :category => "String", :to_be_removed =>false
TableMetaType.create :name => "organisation_hierarchy", :tag_meta_type_id => organisations.id, :description => "Organisation Hierarchy (e.g. Header Office)",  :status => true, :category => "Integer FK", :to_be_removed =>false
TableMetaType.create :name => "organisation_type", :tag_meta_type_id => organisations.id, :description => "Organisation Type (e.g. Enterprise)",  :status => true, :category => "Integer FK", :to_be_removed =>false
TableMetaType.create :name => "business_type", :tag_meta_type_id => organisations.id, :description => "Business Type (e.g. High Tech)",  :status => true, :category => "Integer FK", :to_be_removed =>false
TableMetaType.create :name => "industry_sector", :tag_meta_type_id => organisations.id, :description => "Industry Sector (e.g. IT)",  :status => true, :category => "Integer FK", :to_be_removed =>false
TableMetaType.create :name => "business_category", :tag_meta_type_id => organisations.id, :description => "Business Category (e.g. Web Service Provider)",  :status => true, :category => "Integer FK", :to_be_removed =>false


#Addresses Table
addresses = TableMetaMetaType.create :name => "addresses", :description => "addresses table", :status => true, :category => "enitity", :to_be_removed =>false
TableMetaType.create :name => "building_name", :tag_meta_type_id => addresses.id, :description => "Building Name (e.g. Fola)",  :status => true, :category => "String", :to_be_removed =>false
TableMetaType.create :name => "suite_unit", :tag_meta_type_id => addresses.id, :description => "Suite Unit (e.g. 1302A)",  :status => true, :category => "String", :to_be_removed =>false
TableMetaType.create :name => "street_number", :tag_meta_type_id => addresses.id, :description => "Street Number (e.g. 35A)",  :status => true, :category => "String", :to_be_removed =>false
TableMetaType.create :name => "street_name", :tag_meta_type_id => addresses.id, :description => "Street Name (e.g. Oxford Street)",  :status => true, :category => "String", :to_be_removed =>false
TableMetaType.create :name => "town", :tag_meta_type_id => addresses.id, :description => "Town (e.g. St Leonards)",  :status => true, :category => "String", :to_be_removed =>false
TableMetaType.create :name => "state", :tag_meta_type_id => addresses.id, :description => "State (e.g. NSW)",  :status => true, :category => "String", :to_be_removed =>false
TableMetaType.create :name => "district", :tag_meta_type_id => addresses.id, :description => "District (e.g. District 9)",  :status => true, :category => "String", :to_be_removed =>false
TableMetaType.create :name => "region", :tag_meta_type_id => addresses.id, :description => "Region (e.g. Region A)",  :status => true, :category => "String", :to_be_removed =>false
TableMetaType.create :name => "country", :tag_meta_type_id => addresses.id, :description => "Country (e.g. Australia)",  :status => true, :category => "Integer FK", :to_be_removed =>false
TableMetaType.create :name => "postal_code", :tag_meta_type_id => addresses.id, :description => "Postal Code (e.g. 2021)",  :status => true, :category => "String", :to_be_removed =>false
TableMetaType.create :name => "time_zone", :tag_meta_type_id => addresses.id, :description => "Time Zone (e.g. UTC/GMT +10)",  :status => true, :category => "String", :to_be_removed =>false
TableMetaType.create :name => "map_reference", :tag_meta_type_id => addresses.id, :description => "Map Reference (e.g. 4807.038,N  01131.000,E)",  :status => true, :category => "String", :to_be_removed =>false
TableMetaType.create :name => "bar_code", :tag_meta_type_id => addresses.id, :description => "Bar Code (e.g. 123a456b78c9d)",  :status => true, :category => "String", :to_be_removed =>false
TableMetaType.create :name => "address_type", :tag_meta_type_id => addresses.id, :description => "Address Type (e.g. Home)",  :status => true, :category => "Integer FK", :to_be_removed =>false





#Contacts Table
contacts = TableMetaMetaType.create :name => "contacts", :description => "contacts table", :status => true, :category => "enitity", :to_be_removed =>false
TableMetaType.create :name => "pre_value", :tag_meta_type_id => contacts.id, :description => "Pre_value (e.g. 02)",  :status => true, :category => "String", :to_be_removed =>false
TableMetaType.create :name => "value", :tag_meta_type_id => contacts.id, :description => "Value (e.g. 88888888)",  :status => true, :category => "String", :to_be_removed =>false
TableMetaType.create :name => "post_value", :tag_meta_type_id => contacts.id, :description => "Post_value (e.g. 201)",  :status => true, :category => "String", :to_be_removed =>false
TableMetaType.create :name => "type", :tag_meta_type_id => contacts.id, :description => "Type (e.g. Phone)",  :status => true, :category => "String", :to_be_removed =>false
TableMetaType.create :name => "contact_meta_type", :tag_meta_type_id => contacts.id, :description => "Contact Type (e.g. Home)",  :status => true, :category => "Integer FK", :to_be_removed =>false

#Extras Table
extras = TableMetaMetaType.create :name => "extras",  :description => "extras table", :status => true, :category => "enitity", :to_be_removed =>false
TableMetaType.create :name => "group_value", :tag_meta_type_id => extras.id, :description => "Group_value (e.g. Any String)",  :status => true, :category => "String", :to_be_removed =>false