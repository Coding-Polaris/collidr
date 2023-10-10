class User < ApplicationRecord
  include Wisper::Publisher
  include SaveableBroadcaster

  %i[
    email
    github_name
    name
  ].each do |field|
      validates field,
        uniqueness: true,
        presence: true
    end

  validates :rating,
    numericality: {
      in: (1..5),
      message: "must be between 1 and 5"
    },
    allow_blank: true

  {
    email: /\A\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w+)$\z/,
    github_name: /\A[a-z\d](?:[a-z\d]|-(?=[a-z\d])){0,38}\z/i
  }.each do |field, regex|
      validates_format_of field, with: regex
    end

  has_many :incoming_ratings, as: :ratee, class_name: :rating
  has_many :outgoing_ratings, as: :rater, class_name: :rating

  def rate_user(user, value)
    Rating.create(rater_id: self.id, ratee_id: user.id, value: value)
  end
end
