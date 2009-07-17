# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  # Passes the authenticity token for use in javascript
  def yield_authenticity_token
     if protect_against_forgery?
        "<script type='text/javascript'>
        //<![CDATA[
          window._auth_token_name = \"#{request_forgery_protection_token}\";
          window._auth_token = \"#{form_authenticity_token}\";
        //]]>
        </script>"
      end 
  end


  FLASH_NAMES = [:notice, :warning, :message]

  def flash_messages
    return unless messages = flash.keys.select{|k| FLASH_NAMES.include?(k)}
    formatted_messages = messages.map do |type|
      content_tag :div, :id => type.to_s do
        flash[type]
      end
    end
    flash.discard
    formatted_messages.join
  end

end
