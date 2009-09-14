class UserGroupsController < ApplicationController


  def add_security

  end
  
  def remove_security
    
    
  end

  def show_groups
    @group_meta_meta_types = GroupMetaMetaType.find_by_name("Security",:order => "name")rescue  @group_meta_meta_types =  GroupMetaMetaType.new
  
    @group_meta_types = GroupMetaType.find(:all, :conditions => ["tag_meta_type_id=?", @group_meta_meta_types.id])rescue  @group_meta_types =  GroupMetaType.new

    @groups = GroupType.find(:all, :condition => ["tag_type_id=?", @group_meta_types.id], :order => "name")rescue  @group =  GroupType.new
  end

  respond_to do |format|
    format.js
  end
end
