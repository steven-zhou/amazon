require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DuplicationFormulaDetailsController do
  before(:each) do
    @primary_list = Factory(:primary_list)
    session[:user] = Factory(:login_account).id
    @duplication_formula_detail = Factory(:personal_duplication_formula_detail)
    @duplication_formula = @duplication_formula_detail.duplication_formula
    DuplicationFormulaDetail.stub!(:find).and_return(@duplication_formula_detail)
    DuplicationFormulaDetail.stub!(:new).and_return(@duplication_formula_detail)
  end

  def delete_destroy(options={})
    options[:id] ||= @duplication_formula_detail.id
    xhr :delete, "destroy", options
  end

  def post_create(options={})
    options[:duplication_formula_detail] ||= @duplication_formula_detail.attributes
    xhr :post, "create", options
  end

  describe "Delete Destroy" do
    it "should find the correct duplication_formula_detail for delete" do
      DuplicationFormulaDetail.should_receive(:find).with(@duplication_formula_detail.id).and_return(@duplication_formula_detail)
      delete_destroy
    end

    it "should destroy the duplication_formula_detail" do      
      @duplication_formula_detail.should_receive(:destroy)
      delete_destroy
    end
  end

  describe "Post Create" do
    it "should create a new duplication formula detail" do
      DuplicationFormulaDetail.should_receive(:new).with(hash_including(@duplication_formula_detail.attributes)).and_return(@duplication_formula_detail)
      post_create
    end

    it "should save the new duplication formula detail" do
      @duplication_formula_detail.should_receive(:save)
      post_create
    end
  end
end
