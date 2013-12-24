require "spec_helper"

describe "user can register" do
  it "user is able to register" do
    visit "/users/sign_up"
    fill_in "user_email", with: "jasminaata@example.com"
    fill_in "user_password", with: "password"
    fill_in "user_password_confirmation", with: "password"
    click_button "Sign up"

    expect(page).to have_content "Welcome! You have signed up successfully."
    expect(page).to have_content "jasminaata@example.com"
    expect(page).to have_content 'Logout'
  end
end

describe "user behavior" do
  let(:user) { FactoryGirl.create(:user, 
    email: "test@example.com", 
    password: "new_password"
    )}

  before do 
    visit "/users/sign_in"
    fill_in "user_email", with: "#{ user.email }"
    fill_in "user_password", with: "#{ user.password }"
    click_button "Login"  
  end

  it "displays the user name after successful login" do
    expect(page).to have_content 'Signed in successfully.'
    expect(page).to have_content "#{ user.email }"
    expect(page).to have_content 'Logout'
  end

  describe "user can comment on a blog" do
    let!(:blog) { Blog.create(
      title: "My new yoga page",
      body: "Some description here",
      )
    }
    it "user can comment on a blog" do
      visit "/blogs/1"
      fill_in "comment[body]", with: "Hey buddy, nice blog you!"
      click_button "Comment"

      expect(page).to have_content 'Hey buddy, nice blog you!'
      expect(page).to have_content 'You commented on a blog!'
      
      click_link "Delete"
      
      expect(page).not_to have_content 'Hey buddy, nice blog you!'
      expect(page).to have_content 'Comment was successfully deleted.'
    end
  end
end

describe "admin can add a blog" do
  let!(:admin) { FactoryGirl.create(:user, 
    email: "admin@example.com", 
    password: "admin123",
    admin: true
    )}
  let(:names) {[ "Yoga", "Cooking", "Health", "Thoughts" ]}

  before do
    visit "/users/sign_in"  
    fill_in "user_email", with: "#{ admin.email }"
    fill_in "user_password", with: "#{ admin.password }"
    names.each { |name| Category.create(name: name) }
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

