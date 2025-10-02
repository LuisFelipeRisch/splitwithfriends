class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]

  before_action :build_user, only: %i[ new create ]

  def new; end

  def create
    @user.assign_attributes(safe_params_for_create)

    if @user.save
      redirect_to new_session_path(email: @user.email), flash: { success: "Usuário criado com sucesso!" }
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

    def build_user
      @user = User.new
    end

    def safe_params_for_create
      params.expect(user: %i[ first_name
                              last_name
                              email_address
                              password
                              password_confirmation ])
    end
end
