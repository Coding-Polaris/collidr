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
class User < ApplicationRecord
  include Wisper::Publisher
  include SaveBroadcaster

  %i[
    email
    name
  ].each do |field|
      validates field,
        uniqueness: true,
        presence: true
    end

  validates :github_name,
    uniqueness: true,
    allow_blank: true

  validates :rating,
    numericality: {
      in: (1..5),
      message: "must be from 1 to 5"
    },
    allow_blank: true

  {
    email: /\A\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w+)$\z/,
    github_name: /\A[a-z\d](?:[a-z\d]|-(?=[a-z\d])){0,38}\z/i
  }.each do |field, regex|
      validates_format_of field, with: regex, allow_blank: :github_name
    end

  has_many :incoming_ratings, as: :ratee, class_name: "Rating"
  has_many :outgoing_ratings, as: :rater, class_name: "Rating"
  has_many :posts
  has_many :comments
  has_many :profile_comments, as: :reply, class_name: "Comment"

  def github_name=(value)
    value = nil if value == ""
    super(value)
  end

  def rate_user(user, value)
    Rating.find_or_create_by(rater_id: self.id, ratee_id: user.id).update(value: value)
  end

  private

  def update_rating
    self.rating = Rating.get_average_rating_for(self)
  end
end
