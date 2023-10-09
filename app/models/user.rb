class User < ApplicationRecord
  validates :name, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true
  validate :email_is_valid

  private

  def email_is_valid
    email_valid = (email =~ /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w+)$/)
    errors.add(:email, "is invalid") unless email_valid
    email_valid
  end
end
