require 'rails_helper'

RSpec.describe "users/edit", type: :view do
  let(:user) {
    User.create!(
      name: "MyString",
      email: "example@example.com",
      github_name: "MyString",
      description: "MyText",
      rating: "2.53"
    )
  }

  before(:each) do
    assign(:user, user)
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(user), "post" do

      assert_select "input[name=?]", "user[name]"

      assert_select "input[name=?]", "user[email]"

      assert_select "input[name=?]", "user[github_name]"

      assert_select "textarea[name=?]", "user[description]"

      assert_select "input[name=?]", "user[rating]"
    end
  end
end
