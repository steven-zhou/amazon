class EmploymentsController < ApplicationController
  def show
    @employment = Employment.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def edit
    @employment = Employment.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def create
    @person = Person.find(params[:person_id])
    @employment = @person.employments.new(params[:employment])
    @employment.save
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @employment = Employment.find(params[:id])
    @employment.destroy
    respond_to do |format|
      format.js
    end
  end

end
