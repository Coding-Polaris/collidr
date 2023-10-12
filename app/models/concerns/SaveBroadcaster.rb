module SaveBroadcaster
  extend ActiveSupport::Concern

  included do
    after_create_commit :publish_created
    after_update_commit :publish_updated
    after_validation :publish_validation_failed, if: :errors_present?
  end

  private

  def publish_created
    broadcast(:created, self)
  end

  def publish_updated
    broadcast(:updated, self)
  end

  def publish_validation_failed
    broadcast(:failed, self)
  end

  def errors_present?
    self.errors.present?
  end
end