class PersonalDuplicationFormulasController < ApplicationController

  def update
    @personal_duplication_formula = PersonalDuplicationFormula.find(params[:id].to_i)
    @personal_duplication_formula.update_attributes(params[:personal_duplication_formula])
    @personal_duplication_formula.group = "applied"
    @personal_duplication_formula.save
    if @personal_duplication_formula.save
      flash.now[:message] = flash_message(:message => "Personal Duplication Formula Applied")
    else

    end
    respond_to do |format|
      format.js { render 'duplication_formulas/personal_update.js' }
    end
  end
end
