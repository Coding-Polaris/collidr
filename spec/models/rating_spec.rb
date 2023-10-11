describe Rating, type: :model do
  let(:rating) { create(:rating) }
  subject { rating }

  %i{ rater_id ratee_id value }.each do |field|
    it { should validate_presence_of(field) }
  end

  it { should validate_uniqueness_of(:rater_id).scoped_to(:ratee_id) }

  it { should belong_to(:rater) }
  it { should belong_to(:ratee) }
end
