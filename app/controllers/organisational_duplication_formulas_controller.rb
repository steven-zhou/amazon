class OrganisationalDuplicationFormulasController < ApplicationController

  def update
    @organisational_duplication_formula = OrganisationalDuplicationFormula.find(params[:id].to_i)
    @organisational_duplication_formula.update_attributes(params[:organisational_duplication_formula])
    @organisational_duplication_formula.group = "applied"
    if @organisational_duplication_formula.save
      flash.now[:message] = flash_message(:message => "Organisational Duplication Formula Applied")
    else

    end
    respond_to do |format|
      format.js { render 'duplication_formulas/organisational_update.js' }
    end
  end

  def set_default
    @organisational_duplication_formula_old = OrganisationalDuplicationFormula.default_setting
    @organisational_duplication_formula = OrganisationalDuplicationFormula.new(@organisational_duplication_formula_old.attributes)
    @organisational_duplication_formula.group = "applied"
    if @organisational_duplication_formula.save
      @organisational_duplication_formula_old.duplication_formula_details.each do |i|
        @duplication_formula_detail = DuplicationFormulaDetail.new(i.attributes)
        @duplication_formula_detail.duplication_formula = @organisational_duplication_formula
        @duplication_formula_detail.save
      end
      flash[:message] = flash_message(:message => "Default Organisational Duplication Formula Applied")
      redirect_to duplication_formula_administrations_path()
    end
  end

  def generate
    Organisation.all.each do |organisation|
      organisation.save
    end
    flash.now[:message] = flash_message(:message => "Organisational Duplication Value Is Re-generated")
    respond_to do |format|
      format.js {render 'duplication_formulas/organisational_generate.js'}
    end
  end
end
