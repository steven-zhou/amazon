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

  def update
    @client_setup = ClientSetup.first
    if @client_setup.update_attributes(params[:client_setup])
      flash[:message] = "Client Setup is updated"
    end

    if params[:license]
      redirect_to license_info_client_setups_path
    else
      redirect_to parameters_client_setups_path
    end
  end
end
