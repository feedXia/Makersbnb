require 'pg'

feature "It displays spaces" do
  scenario "a guest can view all spaces in a single page" do
    connection = PG.connect(dbname: 'spaces_test')
    connection.exec("INSERT INTO spaces (name, description, price) VALUES ('Alex House', 'Spacious and cosy', 20);")

    visit "/spaces"
    expect(page).to have_content "Alex House"
    expect(page).to have_content "Spacious and cosy"
    expect(page).to have_content "20"
  end
end

    