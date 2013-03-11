require 'spec_helper'

describe "Main" do
  describe "test articles", :js => true do
    before do
      @name = create_article
    end

    it "create article" do
      page.should have_content(@name)
    end
    it "make article public" do
      all('div').select { |elt| elt.text == "Private" }.first.click
      page.should have_content('Published')
    end
    it "view article" do
      all('a').select {|elt| elt.text == "View" }.first.click
      page.should have_content('Viewing')
    end
    it "edit article" do
      all('a').select {|elt| elt.text == "Edit" }.first.click
      page.should have_content('Editing document')
    end

    it "delete article" do
      elements_numers = all('a').select {|elt| elt.text == "X" }.count
      (elements_numers+1).times do
        all('a').select {|elt| elt.text == "X" }.first.click
        page.driver.browser.switch_to.alert.accept
      end
      page.should have_no_content('test')
    end
  end

end
