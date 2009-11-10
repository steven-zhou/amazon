class PersonalDuplicationFormula < DuplicationFormula


  before_save :delete_old_setting

  def self.default_setting
    PersonalDuplicationFormula.find_by_group("default")
  end

    def self.applied_setting
    PersonalDuplicationFormula.find_by_group("applied")
  end

  private
  def delete_old_setting
    if self.group == "applied"
      @personal_old_settings = PersonalDuplicationFormula.find(:all, :conditions => ["duplication_formulas.group != ?", "default"])
      @personal_old_settings.each do |i|
         if i != self
           i.destroy
           i.duplication_formula_details.each do |j|
             j.destroy
           end
         end
      end
    end
    
  end

end
