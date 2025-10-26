class Expense < ApplicationRecord
  belongs_to :payer, class_name: "User", foreign_key: :payer_id
  belongs_to :group

  enum :category, water: 0,
                  electricity: 1,
                  gas: 2,
                  condominium: 3,
                  market: 4,
                  delivery: 5,
                  rent: 6,
                  maid: 7,
                  leisure: 8,
                  others: 9

  delegate :available_categories, to: :class

  validates :category, presence: true
  validates :paid_value, presence: true, numericality: { greater_than: 0 }, decimal_places: { places: 2 }
  validates :description, presence: true, if: :others?
  validate  :date_must_be_current_or_future

  after_create :syncronize_balance!

  class << self
    def available_categories
      categories.map do |k, v|
        [ human_attribute_name("category.#{k}"), k ]
      end
    end
  end

  private

    def date_must_be_current_or_future
      errors.add(:date, :blank) && return unless date.present?

      beginning_of_month = Date.current.beginning_of_month

      return unless date.before?(beginning_of_month)

      errors.add(:date,
                 :before_current_month,
                 beginning_of_month: beginning_of_month.strftime("%d/%m/%Y"))
    end

  def syncronize_balance!
    month              = date.month
    year               = date.year
    group_users        = group.users
    group_users_length = group_users.length

    paid_value_decimal = paid_value
    prorated_base      = (paid_value_decimal / group_users_length).floor(2)
    non_payer_total    = prorated_base * (group_users_length - 1)
    payer_share        = paid_value_decimal - non_payer_total

    ApplicationRecord.transaction do
      group_users.each do |user|
        group_balance = GroupBalance.find_or_initialize_by(user:, group:, month:, year:)

        if group_balance.user == payer
          group_balance.total_paid_value += paid_value_decimal
          group_balance.balance          += (paid_value_decimal - payer_share)
        else
          group_balance.balance -= prorated_base
        end

        group_balance.save!
      end
    end
  end
end
