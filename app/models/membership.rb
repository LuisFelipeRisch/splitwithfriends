class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :group

  enum :role, member: 0,
              admin: 1,
              default: :member
end
