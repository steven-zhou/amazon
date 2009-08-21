class EmploymentsController < ApplicationController

  before_filter :check_authentication

  def show
    @employment = Employment.find(params[:id].to_i)
    respond_to do |format|
      format.js
    end
  end

  def edit
    @employment = Employment.find(params[:id].to_i)
    @organisation = @employment.organisation
    respond_to do |format|
      format.js
    end
  end

  def create
    @person = Person.find(params[:person_id].to_i)
    @employment = @person.employments.new(params[:employment])
    @employment.save
    respond_to do |format|
      format.js
    end
  end

  def update
    @employment = Employment.find(params[:id].to_i)
    respond_to do |format|
      if @employment.update_attributes(params[:employment][@employment.id.to_s])
        format.js { render 'show.js' }
      end
    end
  end

  def destroy
    @employment = Employment.find(params[:id].to_i)
    @employment.destroy
    respond_to do |format|
      format.js
    end
  end

end
