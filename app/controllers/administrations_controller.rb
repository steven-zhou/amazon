class AdministrationsController < ApplicationController
  def index
    @amazonsetting = AmazonSetting.new
    respond_to do |format|
      format.html
    end
  end
end
