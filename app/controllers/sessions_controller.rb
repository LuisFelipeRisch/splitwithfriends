class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  before_action :set_email_address, only: %i[ new ]
  def new; end

  def create
    if user = User.authenticate_by(params.permit(:email_address, :password))
      start_new_session_for user
      redirect_to after_authentication_url, flash: { success: "Log in realizado com sucesso. Seja bem vindo #{user.full_name}!" }
    else
      redirect_to new_session_path(email_address: params[:email_address]), flash: { alert: "Tente outro email ou senha." }
    end
  end

  def destroy
    user = current_user

    terminate_session
    redirect_to new_session_path, flash: { success: "Log out realizado com sucesso. Até breve #{user.full_name}!" }
  end

  private

    def set_email_address
      @email_address = params[:email_address]
    end
end
