class TransactionsController < ApplicationController
  # System Log stuff added

  def personal_transaction
    @group_types = LoginAccount.find(session[:user]).group_types
    @list_headers = @current_user.all_lists
    @list_header = ListHeader.find(session[:current_list_id])
    @p = @list_header.people_on_list
    @person = Person.find(session[:current_person_id])
    respond_to do |format|
      format.html
    end
  end

  def organisational_transaction

  end

end
