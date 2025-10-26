class GroupBalance < ApplicationRecord
  belongs_to :user
  belongs_to :group

  scope :by_month, lambda { |month:|
    where(month:)
  }

  scope :by_year, lambda { |year:|
    where(year:)
  }

  scope :by_group, lambda { |group:|
    where(group:)
  }

  def balance_to_badge_color
    if balance.negative?
      "danger"
    else
      "success"
    end
  end
end
