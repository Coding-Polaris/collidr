require 'rails_helper'

RSpec.describe "users/new", type: :view do
  before(:each) do
    assign(:user, User.new(
      name: "MyString",
      email: "MyString",
      github_name: "MyString",
      description: "MyText",
      cached_rating: "9.99"
    ))
  end

  it "renders new user form" do
    render

    assert_select "form[action=?][method=?]", users_path, "post" do

      assert_select "input[name=?]", "user[name]"

      assert_select "input[name=?]", "user[email]"

      assert_select "input[name=?]", "user[github_name]"

      assert_select "textarea[name=?]", "user[description]"

      assert_select "input[name=?]", "user[cached_rating]"
    end
  end
end
