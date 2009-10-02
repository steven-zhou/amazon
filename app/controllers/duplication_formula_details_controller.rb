class DuplicationFormulaDetailsController < ApplicationController

  def destroy
    @duplication_formula_detail = DuplicationFormulaDetail.find(params[:id].to_i)
    @duplication_formula_detail.destroy
    respond_to do |format|
      format.js
    end
  end

  def create
    @duplication_formula_detail = DuplicationFormulaDetail.new(params[:duplication_formula_detail])
    @duplication_formula_detail.save
    respond_to do |format|
      format.js
    end
  end

end
