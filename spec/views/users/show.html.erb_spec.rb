require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    assign(:user, User.create!(
      name: "John Wick",
      email: "fatemail@email.gov",
      github_name: "GithubName",
      description: "MyDesc",
      rating: "4.59"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/John Wick/)
    expect(rendered).to match(/fatemail/)
    expect(rendered).to match(/GithubName/)
    expect(rendered).to match(/MyDesc/)
    expect(rendered).to match(/4.59/)
  end
end
