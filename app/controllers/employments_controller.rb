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
    if @employment.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id})  created a new Employment record with ID #{@employment.id}.")
    else
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to create employment record.")
      #----------------------------presence - of----
      if(!@employment.errors[:commenced_date].nil? && @employment.errors.on(:commenced_date).include?("can't be blank"))
#        flash.now[:error] = flash_message(:type => "field_missing", :field => "Position--Start Date")
         flash.now[:error] = "Some Input Field Invalid, Please Check It Again"
      elsif(!@employment.errors[:organisation].nil? && @employment.errors.on(:organisation).include?("can't be blank"))
#        flash.now[:error] = flash_message(:type => "field_missing", :field => "Valid Organisation")
         flash.now[:error] = "Some Input Field Invalid, Please Check It Again"
      elsif(!@employment.errors[:emp_recruiter].nil? && @employment.errors.on(:emp_recruiter).include?("can't be blank"))
#        flash.now[:error] = flash_message(:type => "field_missing", :field => "Valid Position--Hire By")
         flash.now[:error] = "Some Input Field Invalid, Please Check It Again"
        #-----------------------validate--person_must_be_valid------------------------
      elsif(!@employment.errors[:report_to].nil? && @employment.errors.on(:report_to).include?("can't be invalid"))
        flash.now[:error] = flash_message(:type => "invalid_data", :field => "Report To")

      elsif(!@employment.errors[:terminated_by].nil? && @employment.errors.on(:terminated_by).include?("can't be invalid"))
        flash.now[:error] = flash_message(:type => "invalid_data", :field => "Terminated_by")

      elsif(!@employment.errors[:suspended_by].nil? && @employment.errors.on(:suspended_by).include?("can't be invalid"))
        flash.now[:error] = flash_message(:type => "invalid_data", :field => "Suspended_by")


           #-----------------------validate--end_date_must_be_equal_or_after_commence_date----------------------
      elsif(!@employment.errors[:term_end_date].nil? && @employment.errors.on(:term_end_date).include?("can't be before commence date"))
        flash.now[:error] = flash_message(:type => "invalid_date_order", :field => "Term End Date")
      elsif(!@employment.errors[:suspension_end_date].nil? && @employment.errors.on(:suspension_end_date).include?("can't be before suspension start date"))
        flash.now[:error] = flash_message(:type => "invalid_date_order", :field => "Suspension End Date")
      elsif(!@employment.errors[:termination_date].nil? && @employment.errors.on(:termination_date).include?("can't be before termination_notice_date"))
        flash.now[:error] = flash_message(:type => "invalid_date_order", :field => "Termination Date")
      else
        flash.now[:error]= "Some Input Field Invalid, Please Check It Again"
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def update
    @employment = Employment.find(params[:id].to_i)
    respond_to do |format|
      if @employment.update_attributes(params[:employment][@employment.id.to_s])
        system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated Employment ID #{@employment.id}.")
      else
        if(!@employment.errors[:commenced_date].nil? && @employment.errors.on(:commenced_date).include?("can't be blank"))
#        flash.now[:error] = flash_message(:type => "field_missing", :field => "Position--Start Date")
          flash.now[:error] = "Some Input Field Invalid, Please Check It Again"
      elsif(!@employment.errors[:organisation].nil? && @employment.errors.on(:organisation).include?("can't be blank"))
#        flash.now[:error] = flash_message(:type => "field_missing", :field => "Valid Organisation")
          flash.now[:error] = "Some Input Field Invalid, Please Check It Again"
      elsif(!@employment.errors[:emp_recruiter].nil? && @employment.errors.on(:emp_recruiter).include?("can't be blank"))
#        flash.now[:error] = flash_message(:type => "field_missing", :field => "Valid Position--Hire By")
        flash.now[:error] = "Some Input Field Invalid, Please Check It Again"
        #-----------------------validate--person_must_be_valid------------------------
      elsif(!@employment.errors[:report_to].nil? && @employment.errors.on(:report_to).include?("can't be invalid"))
        flash.now[:error] = flash_message(:type => "invalid_data", :field => "Report To")
      elsif(!@employment.errors[:terminated_by].nil? && @employment.errors.on(:terminated_by).include?("can't be invalid"))
        flash.now[:error] = flash_message(:type => "invalid_data", :field => "Terminated_by")
      elsif(!@employment.errors[:suspended_by].nil? && @employment.errors.on(:suspended_by).include?("can't be invalid"))
        flash.now[:error] = flash_message(:type => "invalid_data", :field => "Suspended_by")

           #-----------------------validate--end_date_must_be_equal_or_after_commence_date----------------------
      elsif(!@employment.errors[:term_end_date].nil? && @employment.errors.on(:term_end_date).include?("can't be before commence date"))
        flash.now[:error] = flash_message(:type => "invalid_date_order", :field => "Term End Date")
      elsif(!@employment.errors[:suspension_end_date].nil? && @employment.errors.on(:suspension_end_date).include?("can't be before suspension start date"))
        flash.now[:error] = flash_message(:type => "invalid_date_order", :field => "Suspension End Date")
      elsif(!@employment.errors[:termination_date].nil? && @employment.errors.on(:termination_date).include?("can't be before termination_notice_date"))
        flash.now[:error] = flash_message(:type => "invalid_date_order", :field => "Termination Date")
      else
        flash.now[:error]= "Some Input Field Invalid, Please Check It Again"
      end

      end
        format.js { render 'show.js' }
      
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
    @person = Person.find(@current_employment.person_id)
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
    @person = Person.find(@up_current_employment.person_id)

    respond_to do |format|
      format.js
    end
  end
end
