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
class Rating < ActiveRecord::Base
  include Wisper::Publisher
  include SaveableBroadcaster

  %i[rater_id ratee_id value].each do |field|
    validates field, presence: true
  end

  validates :rater_id, uniqueness: { scope: :ratee_id }
end
