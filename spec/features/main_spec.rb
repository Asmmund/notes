require 'spec_helper'
 feature "test articles", :js => true do

    before(:each) do
      @name = create_article
    end

    scenario "create article" do
      page.should have_content(@name)
    end

    scenario "make article public" do
      all('div').select { |elt| elt.text == "Private" }.first.click
      page.should have_content('Published')
    end

    scenario "view article" do
      link = all('a').select {|elt| elt.text == "View" }.first
      if link
        link.click
        page.should have_content('Viewing')
      else
        raise 'No view link found!'
      end
    end

    scenario "edit article" do
      el =  all('a').select {|elt| elt.text == "Edit" }.first
      el.click if el
      page.should have_content('Editing document')
    end

    scenario "delete article" do
      elements_numers = all('a').select {|elt| elt.text == "X" }.count
      (elements_numers+1).times do
        el = all('a').select {|elt| elt.text == "X" }.first
        el.click if el
        page.driver.browser.switch_to.alert.accept
      end
      page.should have_no_content('test')
    end

  end
