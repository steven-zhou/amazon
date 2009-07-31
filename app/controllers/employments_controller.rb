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

  def update
    @employment = Employment.find(params[:id])
    respond_to do |format|
      if @employment.update_attributes(params[:employment][@employment.id.to_s])
        format.js { render 'show.js' }
      end
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
