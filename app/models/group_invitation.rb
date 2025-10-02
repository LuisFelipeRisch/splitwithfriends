class GroupInvitation < ApplicationRecord
  belongs_to :group

  belongs_to :inviter, class_name: "User", foreign_key: :inviter_id
  belongs_to :invitee, class_name: "User", primary_key: :email_address, foreign_key: :email_address, optional: true

  enum :status, pending: 0,
                accepted: 1,
                refused: 2,
                ignored: 3,
                default: :pending
end
