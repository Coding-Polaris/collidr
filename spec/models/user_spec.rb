# == Schema Information
#
# Table name: users
#
#  id          :bigint           not null, primary key
#  description :text
#  email       :string           not null
#  github_name :string
#  name        :string(30)       not null
#  rating      :decimal(3, 2)
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
  let(:user) { create(:user) }
  subject { user }

  include_examples "SaveBroadcaster", :user

  %i{ email name }.each do |field|
    it { should validate_presence_of(field) }
    it { should validate_uniqueness_of(field) }
  end

  it { should validate_uniqueness_of(:github_name) }
  it { should allow_value("", nil).for(:github_name) }

  it do
    should validate_numericality_of(:rating)
      .is_greater_than_or_equal_to(1)
      .is_less_than_or_equal_to(5)
      .with_message("must be from 1 to 5")
  end

  it { should have_many(:incoming_ratings) }
  it { should have_many(:outgoing_ratings) }
  it { should have_many(:posts) }
  it { should have_many(:comments) }
  it { should have_many(:profile_comments) }

  describe "#email" do
    it "is not valid with an invalid email format" do
      user.email = "invalid_email"
      user.valid?
      expect(user.errors[:email]).to include("is invalid")
    end
  end

  describe "#rating" do 
    it "is valid if rating is empty" do
      user.rating = nil
      user.valid?
      expect(user.errors[:rating]).to be_empty
    end

    it "is equal to an average of the user's total Rating values" do
      create(:rating, ratee: user, value: 4)
      user.send(:update_rating)
      expect(user.rating).to eq(4.to_f.round(2))

      create(:rating, ratee: user, value: 3)
      user.send(:update_rating)
      expect(user.rating).to eq(3.5.to_f.round(2))

      create(:rating, ratee: user, value: 5)
      user.send(:update_rating)
      expect(user.rating).to eq(4.to_f.round(2))
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

  describe "#rate_user" do
    it "should assign a rating to another user" do
      second_user = create(:user)
      user.rate_user(second_user, 4)

      second_user.send(:update_rating)
      expect(second_user.rating).to eq(4)
    end
  end
end
