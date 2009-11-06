class AdministrationsController < ApplicationController

  def index
    redirect_to :action => "system_data"
  end

  def system_data
    respond_to do |format|
      format.html
    end
  end


  def keyword_dict
    respond_to do |format|
      format.html
    end
  end

  def custom_groups
    @tag_meta_type = GroupMetaMetaType.find_by_name("Custom")
    @category = "Group"
    respond_to do |format|
      format.html
    end
  end


  def security_groups
    @tag_meta_type = GroupMetaMetaType.find_by_name("Security")
    @category = "Group"
    respond_to do |format|
      format.html
    end
  end

  def query_tables
    @tag_meta_types = TableMetaMetaType.find(:all, :order => "name asc")
    @category = "Table"
    respond_to do |format|
      format.html
    end
  end

  def master_docs
    @tag_meta_types = MasterDocMetaMetaType.find(:all, :order => "name asc")
    @category = "MasterDoc"
    respond_to do |format|
      format.html
    end
  end

  def role_conditions
    @tag_meta_types = MasterDocMetaMetaType.find(:all, :order => "name asc")
    @category = "MasterDoc"
    respond_to do |format|
      format.html
    end
  end

  def access_permissions
    @tag_meta_types = SystemPermissionMetaMetaType.find(:all, :order => "name asc")
    @category = "SystemPermission"
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
    @tag_meta_types = ContactMetaMetaType.find(:all, :order => "name asc")
    @category = "Contact"
    respond_to do |format|
      format.html
    end
  end

  def group_permissions
    system_management
    render :action => 'system_management'
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
    @group_types = GroupType.system_user_groups
    respond_to do |format|
      format.html
    end
  end

  def group_lists
    @group_types = GroupType.system_user_groups
    respond_to do |format|
      format.html
    end
  end

  def user_accounts
  
    @login_account = SystemUser.new
    @login_accounts = SystemUser.find(:all)rescue @login_accounts = SystemUser.new
    
    @session_timeout = ClientSetup.first.session_timeout
    @grace_period = ClientSetup.first.new_account_graceperiod
    @access_attempts_count = ClientSetup.first.number_of_login_attempts
    @password_lifetime = ClientSetup.first.password_lifetime
   
    respond_to do |format|
      format.html
    end
  end

  def user_groups
    @group_meta_type = GroupMetaType.find(:first, :conditions => ["name=?", "System Users"])rescue  @group_meta_types =  GroupMetaType.new
    @group_types = @group_meta_type.group_types rescue  @group_types =  GroupType.new
    respond_to do |format|
      format.html
    end
  end

  def user_lists
    @login_accounts = SystemUser.find(:all)
    respond_to do |format|
      format.html
    end
  end




end
