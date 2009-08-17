require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TagsController do
  before(:each) do
    @doc_tag = Factory.build(:doc_tag)
    @doc_tag_type = Factory.build(:doc_tag_type)
    @doc_tag_meta_type = Factory.build(:doc_tag_meta_type)
    MasterDocMetaMetaType.stub!(:all).and_return([@doc_meta_type])
    MasterDocMetaMetaType.stub!(:new).and_return(@doc_meta_type)
    MasterDocMetaMetaType.stub!(:find).and_return(@doc_meta_type)
  end

  def get_show_all_for_selected_classifier(options={})
    options["type"] ||= "MasterDocMetaMetaType"
    xhr :get, "show_all_for_selected_classifier", options
  end

  def get_tag_meta_type_new(options={})
    options["type"] ||= "MasterDocMetaMetaType"
    xhr :get, "tag_meta_type_new", options
  end

  def get_tag_meta_type_edit(options={})
    options["type"] ||= "MasterDocMetaMetaType"
    options["id"] ||= @doc_tag_meta_type.id
    xhr :get, "tag_meta_type_edit", options
  end
  
  describe "get show_all_for_selected_classifier" do
    it "should return all meta meta types under selected classifier - MasterDoc" do
      MasterDocMetaMetaType.should_receive(:all).and_return([@doc_meta_type])
      MasterDocMetaMetaType.should_receive(:new).and_return(@doc_meta_type)
      get_show_all_for_selected_classifier
    end

    it "should render template /tags/show_all_for_selected_classifier.js" do
      get_show_all_for_selected_classifier
      response.should render_template("tags/show_all_for_selected_classifier.js.erb")
    end
  end

  describe "get tag_meta_type_new" do
    it "should return a new tag_meta_type with correct type" do
      MasterDocMetaMetaType.should_receive(:new).and_return(@doc_meta_type)
      get_tag_meta_type_new
    end

    it "should render template /tags/tag_meta_type_new.js" do
      get_tag_meta_type_new
      response.should render_template("tags/tag_meta_type_new.js.erb")
    end
  end

  describe "get tag_meta_type_edit" do
    it "should return an existing tag_meta_type with correct id" do
      MasterDocMetaMetaType.should_receive(:find).and_return(@doc_meta_type)
      get_tag_meta_type_edit
    end

    it "should render template /tags/tag_meta_type_edit.js" do
      get_tag_meta_type_edit
      response.should render_template("tags/tag_meta_type_edit.js.erb")
    end
  end


 
end
