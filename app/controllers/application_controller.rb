class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern

  before_action :authorize_current_user_for_action!

  private

    def render_403
      render "errors/403", status: :forbidden
    end

    def authorize_current_user_for_action!
      authorize_method = :"current_user_authorized_for_#{action_name}?"

      render_403 unless respond_to?(authorize_method, true) && send(authorize_method)
    end
end
