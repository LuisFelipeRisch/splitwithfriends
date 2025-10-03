class Group < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships, source: :user
  accepts_nested_attributes_for :memberships, allow_destroy: true

  has_many :group_invitations, dependent: :destroy
  accepts_nested_attributes_for :group_invitations, allow_destroy: true

  validates :name, presence: true, length: { minimum: 3 }
  validates :description, presence: true, length: { minimum: 20 }

  before_create :build_membership_with_creator
  before_create :build_group_invitation_with_creator

  private

    def build_membership_with_creator
      memberships.build(user: User.current, role: :admin)
    end

    def build_group_invitation_with_creator
      group_invitations.build(inviter: User.current, invitee: User.current, status: :accepted)
    end
end
