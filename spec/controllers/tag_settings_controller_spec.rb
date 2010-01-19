require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TagSettingsController do
  before(:each) do
    @primary_list = Factory(:primary_list)
    @doc_tag_meta_type = Factory.build(:doc_tag_meta_type)
    MasterDocMetaMetaType.stub!(:new).and_return(@doc_meta_type)
    session[:user] = Factory(:login_account).id
  end

  def get_show_all_for_selected_classifier(options={})
    options[:tag] ||= "MasterDoc"
    xhr :get, "show_all_for_selected_classifier", options
  end

  describe "get show_all_for_selected_classifier" do
    it "should return all meta meta types under selected classifier - MasterDoc" do
        MasterDocMetaMetaType.stub!(:new).and_return(@doc_meta_type)
#      MasterDocMetaMetaType.should_receive(:find)
      get_show_all_for_selected_classifier
    end

    it "should render template /tag_settings/show_all_for_selected_classifier.js" do
      get_show_all_for_selected_classifier
      response.should render_template("tag_settings/show_all_for_selected_classifier.js.erb")
    end
  end

end
