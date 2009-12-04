class OrganisationBankAccount < BankAccount
    belongs_to :organisation, :foreign_key => "entity_id"

  belongs_to :account_type
    validates_presence_of :account_number,:bank_id,:entity_id
 before_save :update_priority
  before_destroy :update_priority_before_destroy

  private
  def update_priority
    #self.move_to_bottom
    self.priority_number = Organisation.find(self.entity_id).organisation_bank_accounts.length + 1 if self.new_record?
  end

  def update_priority_before_destroy
    priority_number = self.priority_number
    OrganisationBankAccount.transaction do
      Organisation.find(self.entity_id).organisation_bank_accounts.each { |account|
        if (account.priority_number > priority_number)
          account.priority_number -= 1
          account.save!
        end
      }
    end
  end
end
