module Groups
  class MembershipsController < ApplicationController
    DEFAULT_PAGE     = 1
    DEFAULT_PER_PAGE = 25

    before_action :group, only: %i[ index ]

    def index
      @memberships = @group.memberships
                           .strict_loading
                           .page(page)
                           .per(per_page)
                           .order(id: :desc)
                           .includes(:user)
    end

    private

      def group
        @group ||= current_user.groups.find_by(id: params[:group_id])
      end

      def page
        @page ||= params[:page].presence || DEFAULT_PAGE
      end

      def per_page
        @per_page ||= params[:per_page].presence || DEFAULT_PER_PAGE
      end

      def current_user_authorized_for_index? = group
  end
end
