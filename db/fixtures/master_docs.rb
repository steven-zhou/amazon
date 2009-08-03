mdmmt = MasterDocMetaMetaType.create :name => "Licenses"

mdmt = MasterDocMetaType.create :name => "Airplane", :master_doc_meta_meta_type_id => mdmmt.id
mdt = MasterDocType.create :name => "Boeing 747", :master_doc_meta_type_id => mdmt.id
mdt = MasterDocType.create :name => "Boeing 737", :master_doc_meta_type_id => mdmt.id
mdt = MasterDocType.create :name => "Paper aeroplane", :master_doc_meta_type_id => mdmt.id

mdmt = MasterDocMetaType.create :name => "Road Vehicles", :master_doc_meta_meta_type_id => mdmmt.id
mdt = MasterDocType.create :name => "Huge Truck", :master_doc_meta_type_id => mdmt.id
mdt = MasterDocType.create :name => "Little Trck", :master_doc_meta_type_id => mdmt.id
mdt = MasterDocType.create :name => "Car", :master_doc_meta_type_id => mdmt.id

mdmmt = MasterDocMetaMetaType.create :name => "Identification"

mdmt = MasterDocMetaType.create :name => "Government Issued", :master_doc_meta_meta_type_id => mdmmt.id
mdt = MasterDocType.create :name => "Passport", :master_doc_meta_type_id => mdmt.id
mdt = MasterDocType.create :name => "Drivers License", :master_doc_meta_type_id => mdmt.id
mdt = MasterDocType.create :name => "National ID Card", :master_doc_meta_type_id => mdmt.id