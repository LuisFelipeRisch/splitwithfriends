class GroupBalancesController < ApplicationController
  before_action :set_month, only: %i[ index ]
  before_action :set_year, only: %i[ index ]
  before_action :group, only: %i[ index ]
  before_action :set_group_balances, only: %i[ index ]

  helper_method :available_months, :available_years

  def index; end

  private

    def current_date
      @current_date ||= Date.current
    end

    def set_month
      @month = params[:month].presence || current_date.month
    end

    def set_year
      @year = params[:year].presence || current_date.year
    end

    def group
      @group ||= current_user.last_group
    end

    def set_group_balances
      @group_balances = GroupBalance.strict_loading
                              .by_group(group: @group)
                              .by_year(year: @year)
                              .by_month(month: @month)
                              .includes(:user)
    end

    def available_months
      [
        [ "Janeiro", 1 ],
        [ "Fevereiro", 2 ],
        [ "Março", 3 ],
        [ "Abril", 4 ],
        [ "Maio", 5 ],
        [ "Junho", 6 ],
        [ "Julho", 7 ],
        [ "Agosto", 8 ],
        [ "Setembro", 9 ],
        [ "Outubro", 10 ],
        [ "Novembro", 11 ],
        [ "Dezembro", 12 ]
      ]
    end

    def available_years
      year        = current_date.year
      lower_bound = year - 10
      upper_bound = year + 10

      lower_bound..upper_bound
    end

    def current_user_authorized_for_index? = group
end
