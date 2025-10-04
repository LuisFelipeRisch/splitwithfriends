class GroupInvitation < ApplicationRecord
  belongs_to :group

  belongs_to :inviter, class_name: "User", foreign_key: :inviter_id
  belongs_to :invitee, class_name: "User", primary_key: :email_address, foreign_key: :email_address, optional: true

  enum :status, pending: 0,
                accepted: 1,
                refused: 2,
                default: :pending

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  before_validation :set_inviter_with_current_user, on: :create, unless: :inviter

  validates :email_address, presence: true, uniqueness: { scope: :group }, email: true

  private

    def set_inviter_with_current_user
      self.inviter = User.current
    end
end
