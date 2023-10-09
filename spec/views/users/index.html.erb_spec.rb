require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        name: "FreshName",
        email: "Email@email.com",
        github_name: "GHN",
        description: "Desc1!",
        rating: "4.99"
      ),
      User.create!(
        name: "OtherName",
        email: "Email@jim.com",
        github_name: "GithubName",
        description: "Desc2!",
        rating: "1.01"
      )
    ])
  end

  it "renders a list of users" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("FreshName".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("OtherName".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("Email".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("GHN".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("GithubName".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("Desc".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("4.99".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("1.01".to_s), count: 1
  end
end
