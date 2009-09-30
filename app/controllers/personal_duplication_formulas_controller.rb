class PersonalDuplicationFormulasController < ApplicationController

  def new
    @personal_duplication_formula = PersonalDuplicationFormula.new
    @personal_duplication_formula.save
    respond_to do |format|
      format.js { render 'duplication_formulas/personal_new.js' }
    end
  end

  def update
    @personal_duplication_formula = PersonalDuplicationFormula.find(params[:id].to_i)
    @personal_duplication_formula.update_attributes(params[:personal_duplication_formula])
    @personal_duplication_formula.group = "applied"
    @personal_duplication_formula.save
    respond_to do |format|
      format.js { render 'duplication_formulas/personal_create.js' }
    end
  end
end
