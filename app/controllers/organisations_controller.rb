class OrganisationsController < ApplicationController

  def name_finder
    @organisation = Organisation.find(params[:organisation_id]) rescue @organisation = nil
    respond_to do |format|
      format.js {  }
    end
  end

end
