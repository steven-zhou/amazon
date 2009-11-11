class PersonalDuplicationFormulasController < ApplicationController

  def update
    @personal_duplication_formula = PersonalDuplicationFormula.find(params[:id].to_i)
    @personal_duplication_formula.update_attributes(params[:personal_duplication_formula])
    @personal_duplication_formula.group = "applied"
    @personal_duplication_formula.status = params[:personal_duplication_formula][:status]
    @personal_duplication_formula.save
    if @personal_duplication_formula.save
      flash.now[:message] = flash_message(:message => "Personal Duplication Formula Applied")
    else

    end
    respond_to do |format|
      format.js { render 'duplication_formulas/personal_update.js' }
    end
  end

  def set_default
    @personal_duplication_formula_old = PersonalDuplicationFormula.default_setting
    @personal_duplication_formula = PersonalDuplicationFormula.new(@personal_duplication_formula_old.attributes)
    @personal_duplication_formula.group = "applied"
    if @personal_duplication_formula.save
      @personal_duplication_formula_old.duplication_formula_details.each do |i|
        @duplication_formula_detail = DuplicationFormulaDetail.new(i.attributes)
        @duplication_formula_detail.duplication_formula = @personal_duplication_formula
        @duplication_formula_detail.save
      end
      flash[:message] = flash_message(:message => "Default Personal Duplication Formula Applied")
      redirect_to duplication_check_administrations_path()
    end
  end

  def generate
    Person.all.each do |person|      
      person.save
    end
    flash.now[:message] = flash_message(:message => "Personal Duplication Value Is Re-generated")
    respond_to do |format|
      format.js {render 'duplication_formulas/personal_generate.js'}
    end
  end

  def change_status

    @personal_duplication_formula = PersonalDuplicationFormula.applied_setting

    if @personal_duplication_formula.status
       @personal_duplication_formula.status = false
       @personal_duplication_formula.save
    else
      @personal_duplication_formula.status = true
      @personal_duplication_formula.save
    end

     respond_to do |format|
      format.js {render 'duplication_formulas/change_status.js'}
    end
  end


end
