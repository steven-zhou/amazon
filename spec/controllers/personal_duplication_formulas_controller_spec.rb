require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PersonalDuplicationFormulasController do
  before(:each) do
    @primary_list = Factory(:primary_list)
    session[:user] = Factory(:login_account).id
    @personal_duplication_formula_detail = Factory(:personal_duplication_formula_detail)
    @personal_duplication_formula = @personal_duplication_formula_detail.duplication_formula
    PersonalDuplicationFormula.stub!(:new).and_return(@personal_duplication_formula)
    PersonalDuplicationFormula.stub!(:find).and_return(@personal_duplication_formula)
  end

  def put_update(options={})
    options[:id] ||= @personal_duplication_formula.id
    options[:personal_duplication_formula] ||= @personal_duplication_formula.attributes
    xhr :put, "update", options
  end


  describe "Get New" do
    it "should create a new duplication formula" do
      PersonalDuplicationFormula.should_receive(:new)
      xhr :get, "new"
    end

    it "should save the new duplicatin formula" do
      @personal_duplication_formula.should_receive(:save)
      xhr :get, "new"
    end
  end

  describe "Post Create" do
    it "should create a new duplication formula for save" do
      PersonalDuplicationFormula.should_receive(:find).with(@personal_duplication_formula.id).and_return(@personal_duplication_formula)
      put_update
    end

    it "should save the new duplicatin formula" do
      @personal_duplication_formula.should_receive(:update_attributes).with(hash_including(@personal_duplication_formula.attributes))
      put_update
    end
  end
end
