class ActivityItem < ApplicationRecord
  %i[
    activity_type
    activity_id
    description
    user_id
  ].each do |field|
    validates field, presence: true
  end
end
