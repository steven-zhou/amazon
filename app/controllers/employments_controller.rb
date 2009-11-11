class EmploymentsController < ApplicationController
  # System Logging added


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
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id})  created a new Employment record with ID #{@employment.id}.")
    @person = Person.find(session[:user])
    respond_to do |format|
      format.js
    end
  end

  def update
    @employment = Employment.find(params[:id].to_i)
    respond_to do |format|
      if @employment.update_attributes(params[:employment][@employment.id.to_s])
        system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated Employment ID #{@employment.id}.")
        format.js { render 'show.js' }
      end
    end
  end

  def destroy
    @employment = Employment.find(params[:id].to_i)
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted Employment ID #{@employment.id}.")
    @employment.destroy
    
    respond_to do |format|
      format.js
    end
  end

 def move_down_employment_priority
    @current_employment = Employment.find(params[:id])

    if(@current_employment.sequence_no==1)
      @exchange_employment = @current_employment.employee.employments.find_by_sequence_no(2)

      @exchange_employment.sequence_no = 1
      @current_employment.sequence_no = 2
      @exchange_employment.save
      @current_employment.save
    end
    @person = Person.find(session[:user])
    respond_to do |format|
      format.js
    end

 end

 def move_up_employment_priority
  @up_current_employment = Employment.find(params[:id])
    @up_exchange_employment = @up_current_employment.employee.employments.find_by_sequence_no(@up_current_employment.sequence_no - 1)

    @up_exchange_employment.sequence_no = @up_exchange_employment.sequence_no + 1
    @up_current_employment.sequence_no = @up_current_employment.sequence_no - 1

    @up_exchange_employment.save
    @up_current_employment.save
    @person = Person.find(session[:user])

    respond_to do |format|
      format.js
    end
 end
end
