describe ActivityItem, type: :model do
  # shoulda boilerplate
  subject { act = ActivityItem.new() }

  %i[
    activity_type
    activity_id
    description
    user_id
  ].each do |field|
    it { should validate_presence_of(field) }
  end
end