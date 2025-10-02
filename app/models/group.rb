class Group < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships, source: :user

  has_many :group_invitations, dependent: :destroy
end
