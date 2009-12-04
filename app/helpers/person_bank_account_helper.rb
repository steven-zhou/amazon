module PersonBankAccountHelper

   def format_bank_account(account)
    first_line = "#{account.bank.full_name} #{account.bank.branch_name}".squeeze(" ").strip
    second_line = "#{account.account_number}".squeeze(" ").strip
    third_line = "#{account.remarks}".squeeze(" ").strip

    formatted = ""
    formatted += "#{first_line} <br/>" unless first_line.blank?
    formatted += "#{second_line} <br/>" unless second_line.blank?
    formatted += "#{third_line} <br/>" unless third_line.blank?
     return formatted
   end
end
