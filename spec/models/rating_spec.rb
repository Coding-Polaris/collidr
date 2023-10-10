describe Rating, type: :model do
  subject { rating = Rating.new() }

  %i{ rater_id ratee_id value }.each do |field|
    it { should validate_presence_of(field) }
  end

  it { should validate_uniqueness_of(:rater_id).scoped_to(:ratee_id) }
end
