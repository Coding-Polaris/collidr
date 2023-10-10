# This module is intended to make multiple
# models broadcast save/fail state for logging
# or activity recording purposes etc.
module SaveableBroadcaster
  extend ActiveSupport::Concern

  included do
    after_commit :broadcast_save_success, on: [:create, :update]
    after_rollback :broadcast_save_failure, on: [:create, :update]
  end

  def broadcast_save_success
    broadcast(:save_success, self)
  end

  def broadcast_save_failure
    broadcast(:save_failure, self)
  end
end