require "spec_helper"

describe "user logs in" do
  let(:user) { FactoryGirl.create(:user) }

  it "user is able to register" do
    visit "/users/sign_up"
    fill_in "user_email", with: "jasminaata@example.com"
    fill_in "user_password", with: "password"
    fill_in "user_password_confirmation", with: "password"
    click_button "Sign up"

    expect(page).to have_content 'Welcome! You have signed up successfully.'
    expect(page).to have_content "jasminaata@example.com"
    expect(page).to have_content 'Logout'
  end

  it "displays the user name after successful login" do
    visit "/users/sign_in"
    within ".content" do
      fill_in "user_email", with: "test@example.com"
      fill_in "user_password", with: "new_password"
    end
    click_button "Login"

    expect(page).to have_content 'Signed in successfully.'
    expect(page).to have_content 'test@example.com'
    expect(page).to have_content 'Logout'
  end
end

describe "admin can add a blog" do
  before do
    visit "/users/sign_in"  
    fill_in "user_email", with: "admin@example.com"
    fill_in "user_password", with: "admin123"
  end

  it "admin adds new blog" do
    visit "/blogs/new"
    fill_in "blog_title", with: "Zipcar is now in London too!"
    fill_in "blog_body", with: "Go visit the ocean with our company."
    select("Yoga", from: 'blog[category_id]')
    click_button "Create Blog"

    expect(page).to have_content 'Zipcar is now in London too!'
    visit "/categories/1"
    expect(page).to have_content 'Go visit the ocean with our company.'
  end
end