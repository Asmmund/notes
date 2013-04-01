require 'spec_helper'

describe User do
  before(:all) { @user = FactoryGirl.create(:user) }
  after(:all) { User.delete_all; Article.delete_all; }
  context 'Check model attributes' do
    it { should have_many(:articles) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
  end
  context'Check authenticate method' do
    it { User.authenticate(@user.email,@user.password).should eq(@user) }
    it { User.authenticate('elmor@ukr.net','elmor').should be_nil }
  end

end