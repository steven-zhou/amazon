class LoginAccountsController < ApplicationController

  def new
    @login_account = LoginAccount.new
  end

  
end
