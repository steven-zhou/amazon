class MembershipLogsController < ApplicationController
  # System Log stuff added

  def filter
    conditions = Array.new
    unless params[:person_id].blank?
      conditions << ("person_id="+params[:person_id])
    end
    unless params[:performer_id].blank?
      conditions << ("performer_id="+params[:performer_id])
    end
    if valid_date(params[:start_date]) && valid_date(params[:end_date])
      start_date = params[:start_date].to_date.to_s
      end_date = params[:end_date].to_date.to_s
      unless start_date.blank? || end_date.blank?
        start_date = "#{Date.today().last_year.yesterday.to_s}" if start_date.blank?
        end_date = "#{Date.today().tomorrow.to_s}" if end_date.blank?
        conditions << ("start_date=" + start_date)
        conditions << ("end_date=" + end_date)
      end
      @date_valid = true
    else
      @date_valid = false
      flash.now[:error] = "Please make sure the start date and end date are entered in valid format (dd-mm-yyyy)"
    end

    @query = conditions.join("&")
    respond_to do |format|
      format.js
    end
  end
end
