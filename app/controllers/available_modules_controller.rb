class AvailableModulesController < ApplicationController

  def switch_status
    @available_module = AvailableModule.find(params[:id].to_i)
    if @available_module.status
        @available_module.status = false
        @available_module.save
    else
      @available_module.status = true
      @available_module.save
    end
    respond_to do |format|
      format.js
    end
  end
end
