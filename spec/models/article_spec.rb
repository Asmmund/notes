require 'spec_helper'

describe Article do
  context 'Check model attributes' do
    # before(:all) { FactoryGirl.create(:article) }
    # after(:all) { User.delete_all; Article.delete_all; }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
    it { should belong_to(:user) }
  end
end
