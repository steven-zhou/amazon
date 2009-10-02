class OrganisationalDuplicationFormula < DuplicationFormula

  before_save :delete_old_setting

  def self.default_setting
    OrganisationalDuplicationFormula.find_by_group("default")
  end

  def self.applied_setting
    OrganisationalDuplicationFormula.find_by_group("applied")
  end

  private
  def delete_old_setting
    if self.group == "applied"
      @organisational_old_settings = OrganisationalDuplicationFormula.find(:all, :conditions => ["duplication_formulas.group != ?", "default"])
      @organisational_old_settings.each do |i|
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
