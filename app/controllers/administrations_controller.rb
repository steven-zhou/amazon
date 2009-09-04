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
    @query_header = QueryHeader.new
    @query_header.name = QueryHeader.random_name
    @query_header.save
    @query_criteria = QueryCriteria.new
    respond_to do |format|
      format.html
    end
  end
end
