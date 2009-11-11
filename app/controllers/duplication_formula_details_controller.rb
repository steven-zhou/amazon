class DuplicationFormulaDetailsController < ApplicationController
  # System Logging done here...

  def destroy
    @duplication_formula_detail = DuplicationFormulaDetail.find(params[:id].to_i)
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) delete Duplication Formula Detail #{@duplication_formula_detail.id}.")
    @duplication_formula_detail.destroy
    respond_to do |format|
      format.js
    end
  end

  def create
    @duplication_formula_detail = DuplicationFormulaDetail.new(params[:duplication_formula_detail])
    @duplication_formula_detail.save
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created Duplication Formula Detail #{@duplication_formula_detail.id}.") if @duplication_formula_detail.save
    respond_to do |format|
      format.js
    end
  end

end
