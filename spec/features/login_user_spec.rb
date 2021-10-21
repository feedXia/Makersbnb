feature "Adding user" do
  scenario "Login page exists" do
    visit "/user/login"
    expect(page.status_code).to eq 200
  end

  scenario "Page displays a header" do
    visit "/user/login"
    expect(page).to have_content "Log in"
  end

  scenario "Page has form for user to log in" do
    add_user(name: "Hermione Granger", email: "hermione@example.com", password: "bookworm")
    visit "/user/login"
    fill_in "email", with: "hermione@example.com"
    fill_in "password", with: "bookworm"
    click_button "Log in"
    expect(page).to have_content "Welcome to MakersBnB"
  end

  scenario "Say that details are not corract if details doesn't match" do
    visit "/user/login"
    fill_in "email", with: "hermione@example.com"
    fill_in "password", with: "bookworm"
    click_button "Log in"
    expect(page).to have_content "email or password is wrong :("
  end
end
