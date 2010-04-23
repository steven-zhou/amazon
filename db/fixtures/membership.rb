puts "Initializing Membership template"

PersonMailTemplate.create :name=>"Membership Initiate Template", :body=>"<p>hi,</p>
<p>Your application has been&nbsp; initiated.</p>
<p>&nbsp;</p>
<p>Amazon</p>" , :status => true,:to_be_removed =>false ,:template_category_id=> TemplateCategory.find_by_name('Membership').id

PersonMailTemplate.create :name=>"Membership Review Template", :body=>"<p>hi,</p>
<p>Your application has been&nbsp; reviewed.</p>
<p>&nbsp;</p>
<p>Amazon</p>" , :status => true,:to_be_removed =>false ,:template_category_id=> TemplateCategory.find_by_name('Membership').id

PersonMailTemplate.create :name=>"Membership Approve Template", :body=>"<p>hi,</p>
<p>Your application has been&nbsp; approved.</p>
<p>&nbsp;</p>
<p>Amazon</p>" , :status => true,:to_be_removed =>false ,:template_category_id=> TemplateCategory.find_by_name('Membership').id

PersonMailTemplate.create :name=>"Membership Reject Template", :body=>"<p>hi,</p>
<p>Your application has been&nbsp; rejected.</p>
<p>&nbsp;</p>
<p>Amazon</p>" , :status => true,:to_be_removed =>false ,:template_category_id=> TemplateCategory.find_by_name('Membership').id


PersonEmailTemplate.create :name=>"Membership Initiate Email Template", :body=>"<p>hi,</p>
<p>Your application has been&nbsp; initiated.</p>
<p>&nbsp;</p>
<p>Amazon</p>" , :status => true,:to_be_removed =>false ,:template_category_id=> TemplateCategory.find_by_name('Membership').id

PersonEmailTemplate.create :name=>"Membership Review Email Template", :body=>"<p>hi,</p>
<p>Your application has been&nbsp; reviewed.</p>
<p>&nbsp;</p>
<p>Amazon</p>" , :status => true,:to_be_removed =>false ,:template_category_id=> TemplateCategory.find_by_name('Membership').id

PersonEmailTemplate.create :name=>"Membership Approve Email Template", :body=>"<p>hi,</p>
<p>Your application has been&nbsp; approved.</p>
<p>&nbsp;</p>
<p>Amazon</p>" , :status => true,:to_be_removed =>false ,:template_category_id=> TemplateCategory.find_by_name('Membership').id

PersonEmailTemplate.create :name=>"Membership Reject Email Template", :body=>"<p>hi,</p>
<p>Your application has been&nbsp; rejected.</p>
<p>&nbsp;</p>
<p>Amazon</p>" , :status => true,:to_be_removed =>false ,:template_category_id=> TemplateCategory.find_by_name('Membership').id