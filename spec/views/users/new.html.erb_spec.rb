require 'rails_helper'

RSpec.describe "users/new", type: :view do
  before(:each) do
    assign(:user, User.new(
      name: "MyString",
      email: "newuser@gmail.com",
      github_name: "MyString",
      description: "MyText",
      rating: "4.20"
    ))
  end

  it "renders new user form" do
    render

    assert_select "form[action=?][method=?]", users_path, "post" do

      assert_select "input[name=?]", "user[name]"

      assert_select "input[name=?]", "user[email]"

      assert_select "input[name=?]", "user[github_name]"

      assert_select "textarea[name=?]", "user[description]"

      assert_select "input[name=?]", "user[rating]"
    end
  end
end
