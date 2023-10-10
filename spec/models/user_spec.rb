# == Schema Information
#
# Table name: users
#
#  id          :bigint           not null, primary key
#  description :text
#  email       :string
#  github_name :string
#  name        :string(30)
#  rating      :decimal(3, 2)    default(0.0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_users_on_email        (email)
#  index_users_on_github_name  (github_name)
#  index_users_on_name         (name)
#  index_users_on_rating       (rating)
#
describe User, type: :model do
  # shoulda boilerplate
  subject { user = User.new() }

  %i{ email github_name name }.each do |field|
    it { should validate_presence_of(field) }
    it { should validate_uniqueness_of(field) }
  end

  user = User.new()

  describe "#email" do
    it "is not valid with an invalid email format" do
      user.email = "invalid_email"
      user.valid?
      expect(user.errors[:email]).to include("is invalid")
    end
  end

  describe "#rating" do 
    it "is only valid if rating is between one and five" do
      user.rating = 6
      user.valid?
      expect(user.errors[:rating]).to include("must be between 1 and 5")
    end

    it "is valid if rating is a decimal between one and five" do
      user.rating = 3.69
      user.valid?
      expect(user.errors[:rating]).to be_empty
    end

    it "is valid if rating is empty" do
      user.rating = nil
      user.valid?
      expect(user.errors[:rating]).to be_empty
    end
  end

  describe "#github_name" do
    it "should reject names with multiple hyphens" do
      user.github_name = "many--hyphens"
      user.valid?
      expect(user.errors[:github_name]).to include("is invalid")
    end

    it "should reject names with invalid characters" do
      user.github_name = "invalid characters!"
      user.valid?
      expect(user.errors[:github_name]).to include("is invalid")
    end

    it "should accept names with valid characters" do
      user.github_name = "valid-username"
      user.valid?
      expect(user.errors[:github_name]).to be_empty
    end
  end
end
