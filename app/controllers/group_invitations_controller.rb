class GroupInvitationsController < ApplicationController
  DEFAULT_PAGE     = 1
  DEFAULT_PER_PAGE = 25

  before_action :set_group_invitations, only: %i[ index ]
  before_action :group_invitation, only: %i[ update ]

  def index; end

  def update
    @group_invitation.status = params[:status]

    redirect_to group_path(@group_invitation.group), flash: { success: "Convite aceito com sucesso!" } if @group_invitation.save && @group_invitation.accepted?
  end

  private

    def page
      @page ||= params[:page].presence || DEFAULT_PAGE
    end

    def per_page
      @per_page ||= params[:per_page].presence || DEFAULT_PER_PAGE
    end

    def group_invitation
      @group_invitation ||= current_user.received_group_invitations
                                        .strict_loading
                                        .pending
                                        .includes(:group, :invitee)
                                        .find_by(id: params[:id])
    end

    def set_group_invitations
      @group_invitations = current_user.received_group_invitations
                                       .strict_loading
                                       .pending
                                       .page(page)
                                       .per(per_page)
                                       .includes(:inviter, :group)
    end

    def current_user_authorized_for_index? = current_user

    def current_user_authorized_for_update? = group_invitation
end
