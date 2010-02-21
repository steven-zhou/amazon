# To change this template, choose Tools | Templates
# and open the template in the editor.

puts "Initializing MemberZone user"
@memberzone = MemberZone.new
@memberzone.callback_flag = true
@memberzone.user_name = "MemberZone"
@memberzone.security_email = "memberzone@memberzone.com.au"
@memberzone.password = "3Jumentos4u2"
@memberzone.access_attempts_count = 99
@memberzone.session_timeout = 999999
@memberzone.authentication_grace_period = 9
@memberzone.password_by_admin = false
@memberzone.password_lifetime = 365
@memberzone.login_status = true
@memberzone.save

LoginAccount.current_user = @memberzone
@memberzone.creator_id = @memberzone.id

@memberzone.save