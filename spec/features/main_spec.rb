require 'spec_helper'

describe "Main" do
  describe "test articles", :js => true do
    before(:each) do
      @name = create_article
    end
    def create_article
      name = 'test'+rand(100).to_s
      visit '/articles'
      fill_in 'name', with: name
      click_button 'create_article'
      name
    end
    it "create article" do

      page.should have_content(@name)
    end
    it "view article" do

      all('a').select {|elt| elt.text == "View" }.first.click
      page.should have_content('Viewing')
    end
    it "edit article" do

      all('a').select {|elt| elt.text == "Edit" }.first.click
      page.should have_content('Editing document')
    end
    it "make article public" do

      all('div').select { |elt| elt.text == "Private" }.first.click
      page.status.should be(200)
    end

    it "delete article" do

      all('a').select {|elt| elt.text == "X" }.map do |link|
        link.click
        page.driver.browser.switch_to.alert.accept
      end
      page.should have_no_content('test')
    end
  end

end
