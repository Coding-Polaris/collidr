describe User, type: :model do
  let(:user) { User.new() }

  it "is not valid without a name" do
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end

  it "is not valid without an email" do
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is not valid with a duplicate name" do
    User.create(name: "John", email: "john@example.com")
    user.name = "John"
    user.email = "test@example.com"
    user.valid?
    expect(user.errors[:name]).to include("has already been taken")
  end

  it "is not valid with a duplicate email" do
    User.create(name: "John", email: "john@example.com")
    user.name = "Jane"
    user.email = "john@example.com"
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end

  it "is not valid with an invalid email format" do
    user.email = "invalid_email"
    user.valid?
    expect(user.errors[:email]).to include("is invalid")
  end
end
