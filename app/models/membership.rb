class Membership < ApplicationRecord
  ROLE_TO_BADGE_COLOR_MAPPING = {
    admin: "primary",
    member: "secondary"
  }.with_indifferent_access

  belongs_to :user
  belongs_to :group

  enum :role, member: 0,
              admin: 1,
              default: :member

  def role_to_badge_color
    ROLE_TO_BADGE_COLOR_MAPPING[role]
  end
end
