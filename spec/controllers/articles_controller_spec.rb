require 'spec_helper'

describe "api/articles" do
  integrate_views

  before do
    @article = FactoryGirl.create(:article)
  end
 xit "index action " do
    get 'articles'
    expect(response).to be_success
    expect(response.code).to eq(200)
  end



end
