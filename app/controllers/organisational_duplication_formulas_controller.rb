class OrganisationalDuplicationFormulasController < ApplicationController

  def update
    @organisatonal_duplication_formula = OrganisationalDuplicationFormula.find(params[:id].to_i)
    @organisatonal_duplication_formula.update_attributes(params[:organisatonal_duplication_formula])
    @organisatonal_duplication_formula.group = "applied"
    if @organisatonal_duplication_formula.save
      flash.now[:message] = flash_message(:message => "Organisational Duplication Formula Applied")
    else

    end
    respond_to do |format|
      format.js { render 'duplication_formulas/organisational_update.js' }
    end
  end
end
