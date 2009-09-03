class AdministrationsController < ApplicationController

  before_filter :check_authentication

  def system_setting
    respond_to do |format|
      format.html
    end
  end

  def system_management
    @role = Role.new
    @role_condition = RoleCondition.new
    @role_type = RoleType.new
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
