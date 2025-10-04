class HomeController < ApplicationController
  allow_unauthenticated_access only: %i[ index ]

  def index; end

  private

    def current_user_authorized_for_index? = true
end
