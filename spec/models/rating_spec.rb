# == Schema Information
#
# Table name: ratings
#
#  id         :bigint           not null, primary key
#  value      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  ratee_id   :integer
#  rater_id   :integer
#
# Indexes
#
#  index_ratings_on_ratee_id               (ratee_id)
#  index_ratings_on_rater_id_and_ratee_id  (rater_id,ratee_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (ratee_id => users.id)
#  fk_rails_...  (rater_id => users.id)
#
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
