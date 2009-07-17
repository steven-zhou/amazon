require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe KeywordLink do
  it { should belong_to(:keyword) }
  it { should belong_to(:taggable, :polymorphic => true) }
end
