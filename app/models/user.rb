class User < ApplicationRecord
  EXPECTED_PASSWORD_FORMAT = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).+\z/

  has_secure_password
  has_many :sessions, dependent: :destroy

  has_many :memberships, dependent: :destroy
  has_many :groups, through: :memberships, source: :group

  has_many :sent_group_invitations, class_name: "GroupInvitation", foreign_key: :inviter_id, dependent: :destroy
  has_many :received_group_invitations, class_name: "GroupInvitation", primary_key: :email_address, foreign_key: :email_address, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :first_name, :last_name, presence: true, length: { minimum: 3 }
  validates :email_address, presence: true, uniqueness: true, email: true
  validates :password, :password_confirmation, length: { minimum: 8 }, format: { with: EXPECTED_PASSWORD_FORMAT }

  def full_name
    "#{first_name} #{last_name}"
  end
end
