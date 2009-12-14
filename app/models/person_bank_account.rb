class PersonBankAccount < BankAccount

  belongs_to :person, :foreign_key => "entity_id"
  #belongs_to :bank
  belongs_to :account_type

  validates_presence_of :account_number,:bank_id,:entity_id,:account_type



  before_save :update_priority
  before_destroy :update_priority_before_destroy

  private
  def update_priority
    #self.move_to_bottom
    self.priority_number = Person.find(self.entity_id).person_bank_accounts.length + 1 if self.new_record?
  end

  def update_priority_before_destroy
    priority_number = self.priority_number
    PersonBankAccount.transaction do
      Person.find(self.entity_id).person_bank_accounts.each { |account|
        if (account.priority_number > priority_number)
          account.priority_number -= 1
          account.save!
        end
      }
    end
  end

end
