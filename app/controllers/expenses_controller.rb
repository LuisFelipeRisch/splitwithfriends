class ExpensesController < ApplicationController
  before_action :group, only: %i[ new ]
  before_action :build_expense, only: %i[ new create ]

  def new; end

  def create
    @expense.assign_attributes(safe_params_for_create)

    if @expense.save
      month = @expense.month
      year  = @expense.year

      redirect_to group_balances_path(month:, year:), flash: { success: "Despesa adicionada com sucesso!" }
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

    def group
      @group ||= current_user.last_group
    end

    def build_expense
      @expense = Expense.new(group:, payer: current_user)
    end

    def safe_params_for_create
      params.expect(expense: %i[ category paid_value date description ])
    end

    def current_user_authorized_for_new? = group

    def current_user_authorized_for_create? = group
end
