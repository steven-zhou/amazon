class ClientSetupsController < ApplicationController

  def parameters
    @client_setup = ClientSetup.first
    respond_to do |format|
      format.html
    end
  end

  def license_info
    @client_setup = ClientSetup.first
    @client_organisation = @client_setup.client_organisation
    respond_to do |format|
      format.html
    end
  end
end
