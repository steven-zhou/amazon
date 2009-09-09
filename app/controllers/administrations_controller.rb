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
    respond_to do |format|
      format.html
    end
  end

  def list_management
    respond_to do |format|
      format.html
    end
  end
end
