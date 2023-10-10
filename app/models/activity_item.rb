# == Schema Information
#
# Table name: activity_items
#
#  id            :bigint           not null, primary key
#  activity_time :datetime
#  activity_type :string           not null
#  description   :text             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  activity_id   :integer          not null
#  user_id       :integer          not null
#
# Indexes
#
#  index_activity_items_on_activity_id  (activity_id)
#  index_activity_items_on_user_id      (user_id)
#
class ActivityItem < ApplicationRecord
end
