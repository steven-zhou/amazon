class AdministrationsController < ApplicationController

  def index
    redirect_to :action => "system_data"
  end

  def system_data
    respond_to do |format|
      format.html
    end
  end

  def custom_groups
    @custom_groups = GroupMetaMetaType.find_by_name("Custom")
    respond_to do |format|
      format.html
    end
  end

  def query_tables
    @query_tables = TableMetaMetaType.find(:all)
    respond_to do |format|
      format.html
    end
  end

  def master_docs
    respond_to do |format|
      format.html
    end
  end


  def roles_management

    @role = Role.new
    respond_to do |format|
      format.html
    end
  end

  def contact_types
    respond_to do |format|
      format.html
    end
  end


  def access_permissions
    @access_permissions = SystemPermissionMetaMetaType.find(:all)

    respond_to do |format|
      format.html
    end
  end


  def group_permissions
    system_management
    render :action => 'system_management'
  end


  def group_lists
    system_management
    render :action => 'system_management'
  end


  def security_groups
    @security_groups = GroupMetaMetaType.find_by_name("Security")

    respond_to do |format|
      format.html
    end
  end


  def user_accounts
    system_management
    render :action => 'system_management'
  end


  def user_groups

    @group_meta_type = GroupMetaType.find(:first, :conditions => ["name=?", "System Users"])rescue  @group_meta_types =  GroupMetaType.new
   
    @group_types = @group_meta_type.group_types rescue  @group_types =  GroupType.new
    
#    @login_account = LoginAccount.find(params[:login_account_id])
#    @groups = @login_account.group_types



    respond_to do |format|
      format.html
    end
  end


  def user_lists
    respond_to do |format|
      format.html
    end
  end
 

  def duplication_check
    @personal_duplication_formula_old = PersonalDuplicationFormula.applied_setting
    @personal_duplication_formula_old = PersonalDuplicationFormula.default_setting if @personal_duplication_formula_old.nil?
    @personal_duplication_formula = PersonalDuplicationFormula.new(@personal_duplication_formula_old.attributes)
    @personal_duplication_formula.group = "temp"
    if @personal_duplication_formula.save
      @personal_duplication_formula_old.duplication_formula_details.each do |i|
        @duplication_formula_detail = DuplicationFormulaDetail.new(i.attributes)
        @duplication_formula_detail.duplication_formula = @personal_duplication_formula
        @duplication_formula_detail.save
      end
    end

    @organisational_duplication_formula_old = OrganisationalDuplicationFormula.applied_setting
    @organisational_duplication_formula_old = OrganisationalDuplicationFormula.default_setting if @organisational_duplication_formula_old.nil?
    @organisational_duplication_formula = OrganisationalDuplicationFormula.new(@organisational_duplication_formula_old.attributes)
    @organisational_duplication_formula.group = "temp"
    if @organisational_duplication_formula.save
      @organisational_duplication_formula_old.duplication_formula_details.each do |i|
        @duplication_formula_detail = DuplicationFormulaDetail.new(i.attributes)
        @duplication_formula_detail.duplication_formula = @organisational_duplication_formula
        @duplication_formula_detail.save
      end
    end

    respond_to do |format|
      format.html
    end
  end


  def group_permissions

    @role = Role.new
    @role_condition = RoleCondition.new
    @role_type = RoleType.new
    @login_account = LoginAccount.new
    @login_accounts = LoginAccount.find(:all)rescue @login_accounts = LoginAccount.new
    @user_group = UserGroup.new
    @group_all = Array.new
    c = GroupMetaType.find(:first, :conditions => ["name=?","System Users"])
    @group_all = c.group_types rescue @group_all = Array.new

    @module_all = Array.new
    c = GroupMetaMetaType.find(:all, :conditions => ["type=?","SystemPermissionMetaMetaType"])rescue c = Array.new
    @module_all = c

    respond_to do |format|
      format.html
    end
  end

 def group_lists

    @role = Role.new
    @role_condition = RoleCondition.new
    @role_type = RoleType.new
    @login_account = LoginAccount.new
    @login_accounts = LoginAccount.find(:all)rescue @login_accounts = LoginAccount.new
    @user_group = UserGroup.new
    @group_all = Array.new
    c = GroupMetaType.find(:first, :conditions => ["name=?","System Users"])
    @group_all = c.group_types rescue @group_all = Array.new

    @module_all = Array.new
    c = GroupMetaMetaType.find(:all, :conditions => ["type=?","SystemPermissionMetaMetaType"])rescue c = Array.new
    @module_all = c

    respond_to do |format|
      format.html
    end
  end

 def user_accounts

    @role = Role.new
    @role_condition = RoleCondition.new
    @role_type = RoleType.new
    @login_account = LoginAccount.new
    @login_accounts = LoginAccount.find(:all)rescue @login_accounts = LoginAccount.new
    @user_group = UserGroup.new
    @group_all = Array.new
    c = GroupMetaType.find(:first, :conditions => ["name=?","System Users"])
    @group_all = c.group_types rescue @group_all = Array.new

    @module_all = Array.new
    c = GroupMetaMetaType.find(:all, :conditions => ["type=?","SystemPermissionMetaMetaType"])rescue c = Array.new
    @module_all = c

    respond_to do |format|
      format.html
    end
  end



 def user_lists

    @role = Role.new
    @role_condition = RoleCondition.new
    @role_type = RoleType.new
    @login_account = LoginAccount.new
    @login_accounts = LoginAccount.find(:all)rescue @login_accounts = LoginAccount.new
    @user_group = UserGroup.new
    @group_all = Array.new
    c = GroupMetaType.find(:first, :conditions => ["name=?","System Users"])
    @group_all = c.group_types rescue @group_all = Array.new

    @module_all = Array.new
    c = GroupMetaMetaType.find(:all, :conditions => ["type=?","SystemPermissionMetaMetaType"])rescue c = Array.new
    @module_all = c

    respond_to do |format|
      format.html
    end
  end


#  def system_setting
#    respond_to do |format|
#      format.html
#    end
#  end
#
#
#  def system_management
#
#    @role = Role.new
#    @role_condition = RoleCondition.new
#    @role_type = RoleType.new
#    @login_account = LoginAccount.new
#    @login_accounts = LoginAccount.find(:all)rescue @login_accounts = LoginAccount.new
#    @user_group = UserGroup.new
#    @group_all = Array.new
#    c = GroupMetaType.find(:first, :conditions => ["name=?","System Users"])
#    @group_all = c.group_types rescue @group_all = Array.new
#
#    @module_all = Array.new
#    c = GroupMetaMetaType.find(:all, :conditions => ["type=?","SystemPermissionMetaMetaType"])rescue c = Array.new
#    @module_all = c
#
#    respond_to do |format|
#      format.html
#    end
#  end

  def duplication_formula
    @personal_duplication_formula_old = PersonalDuplicationFormula.applied_setting
    @personal_duplication_formula_old = PersonalDuplicationFormula.default_setting if @personal_duplication_formula_old.nil?
    @personal_duplication_formula = PersonalDuplicationFormula.new(@personal_duplication_formula_old.attributes)
    @personal_duplication_formula.group = "temp"
    if @personal_duplication_formula.save
      @personal_duplication_formula_old.duplication_formula_details.each do |i|
        @duplication_formula_detail = DuplicationFormulaDetail.new(i.attributes)
        @duplication_formula_detail.duplication_formula = @personal_duplication_formula
        @duplication_formula_detail.save
      end
    end

    @organisational_duplication_formula_old = OrganisationalDuplicationFormula.applied_setting
    @organisational_duplication_formula_old = OrganisationalDuplicationFormula.default_setting if @organisational_duplication_formula_old.nil?
    @organisational_duplication_formula = OrganisationalDuplicationFormula.new(@organisational_duplication_formula_old.attributes)
    @organisational_duplication_formula.group = "temp"
    if @organisational_duplication_formula.save
      @organisational_duplication_formula_old.duplication_formula_details.each do |i|
        @duplication_formula_detail = DuplicationFormulaDetail.new(i.attributes)
        @duplication_formula_detail.duplication_formula = @organisational_duplication_formula
        @duplication_formula_detail.save
      end
    end

    respond_to do |format|
      format.html
    end
  end

end
