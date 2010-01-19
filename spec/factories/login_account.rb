Factory.define :login_account, :class => LoginAccount do |f|
  f.sequence(:user_name) { |n| "Username#{n}" }
  f.sequence(:security_email) { |n| "address_#{n}@email.com" }
  f.sequence(:password_hint) { |n| "Password Hint #{n}" }
  f.sequence(:question1_answer) { |n| "Security Question 1 #{n}" }
  f.sequence(:question2_answer) { |n| "Security Question 2 #{n}" }
  f.sequence(:question3_answer) { |n| "Security Question 3 #{n}" }
  f.sequence(:password) {|n| "Password#{n}"}

  f.password_last_date 99.days.ago
  f.last_login 10.days.ago
  f.last_logoff 9.days.ago
  f.sequence(:last_ip_address) { |n| "127.0.0.#{n}" }
  f.session_timeout 10
  f.login_status true
  f.system_user true

  f.association :security_question_1, :factory => :security_question1
  f.association :security_question_2, :factory => :security_question2
  f.association :security_question_3, :factory => :security_question3
  #f.association :group_type, :factory => :group_type
  
 
end
