class AdministrationsController < ApplicationController

  def system_setting
    respond_to do |format|
      format.html
    end
  end

  def system_management

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

  def list_management
    respond_to do |format|
      format.html
    end
  end

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
