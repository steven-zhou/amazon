Factory.define :cmt_email, :class => ContactMetaType do |f|
  f.name "Email"
end

Factory.define :cmt_phone, :class => ContactMetaType do |f|
  f.name "Phone"
end

Factory.define :cmt_fax, :class => ContactMetaType do |f|
  f.name "Fax"
end

Factory.define :cmt_website, :class => ContactMetaType do |f|
  f.name "Website"
end