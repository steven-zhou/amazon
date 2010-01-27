class UserPreferencesController < ApplicationController


  def change_email
    current_user = LoginAccount.find(session[:user])

    if current_user.security_email == params[:old_email]

#     current_user.security_email = params[:new_email]
       unless current_user.update_attribute(:security_email,params[:new_email])    
        flash[:error]="Can not save"
       end
    else
     flash[:error]="old and new is not the same"

    end

     respond_to do |format|
      format.js
    end
    
  end


  def change_password
    current_user = LoginAccount.find(session[:user])
   if (Digest::SHA256.hexdigest(params[:old_password] + current_user.password_salt) == current_user.password_hash)
        current_user.password = params[:new_password]
       unless current_user.save
        flash[:error]="Can not save"
       end
    else
     flash[:error]="old and new password is not the same"

    end

     respond_to do |format|
      format.js
    end
    
  end


  def change_security_question
   @login_account = LoginAccount.find(session[:user])
#   current_user.question1_answer = params[:login_account][:question1_answer]
#   current_user.question2_answer = params[:login_account][:question2_answer]
#   current_user.question3_answer = params[:login_account][:question3_answer]
#   current_user.security_question1_id = params[:login_account][:security_question1_id]
#   current_user.security_question2_id = params[:login_account][:security_question2_id]
#   current_user.security_question3_id = params[:login_account][:security_question3_id]
#params[:login_account][:password] = "haha"
  if  @login_account.update_attributes(params[:login_account])
#   if current_user.save!
      flash[:error] = " Saved successfully"

       system_log("Login Account #{@login_account.user_name} (#{@login_account.id}) updated their security question.")
   else
     system_log("Login Account #{@login_account.user_name} (#{@login_account.id}) had an error when attempting to update their security question .")
#     flash[:error] = flash_message(:type => "field_missing", :field => "question1_answer")if(!current_user.errors[:question1_answer].nil? && current_user.errors.on(:question1_answer).include?("you must type three security questions answer."))
#     flash[:error] = flash_message(:type => "field_missing", :field => "question2_answer")if(!current_user.errors[:question2_answer].nil? && current_user.errors.on(:question2_answer).include?("you must type three security questions answer."))
#      flash[:error] = flash_message(:type => "field_missing", :field => "question3_answer")if(!current_user.errors[:question3_answer].nil? && current_user.errors.on(:question3_answer).include?("you must type three security questions answer."))
   flash[:error] = "you must type three security questions answer."
   end

    respond_to do |format|
      format.js {render 'change_password.js'}
    end
  end

  def  show_modify_my_account

  @my_account = LoginAccount.find(session[:user])
   respond_to do |format|
      format.js
    end
  end




  
end
