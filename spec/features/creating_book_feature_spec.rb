require 'rails_helper'

RSpec.feature "Creating Books" do
    
    let!(:peachpit) { Fabricate(:publisher, name: 'Peachpit Press') }
    let!(:author1) { Fabricate(:author) }
    let!(:author2) { Fabricate(:author) }
    
    scenario "with valid inputs succeed" do
        
        visit root_path
        
        click_link "Books", exact: true
        click_link "Add New Book"
        
        fill_in "Title", with: "Javascript"
        fill_in "Isbn", with: "9780321772978"
        fill_in "Page count", with: 518
        fill_in "Price", with: 34.99
        fill_in "Description", with: "Learn Javascript with a quick and easy way"
        fill_in "Published at", with: "2014-01-01"
        select "Peachpit Press", from: "Publisher"
        check author1.full_name
        check author2.full_name
        
        
        click_button "Create Book"
        
        expect(page).to have_content("Book has been created")
    end
    
end