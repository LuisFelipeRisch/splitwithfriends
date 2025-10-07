class GroupsController < ApplicationController
  before_action :redirect_to_new_if_should_on_index, only: %i[ index ], if: :should_redirect_to_new_on_index?
  before_action :redirect_to_show_if_should_on_index, only: %i[ index ], if: :should_redirect_to_show_on_index?
  before_action :build_group, only: %i[ new create ]
  before_action :group, only: %i[ show ]

  def index; end

  def show; end

  def new; end

  def create
    @group.assign_attributes(safe_params_for_create)

    if @group.save
      redirect_to group_path(@group), flash: { success: "Grupo criado com sucesso!" }
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

    def should_redirect_to_new_on_index?
      current_user.last_group.nil?
    end

    def redirect_to_new_if_should_on_index
      redirect_to new_group_path
    end

    def should_redirect_to_show_on_index?
      current_user.last_group
    end

    def redirect_to_show_if_should_on_index
      redirect_to group_path(current_user.last_group)
    end

    def build_group
      @group = Group.new
    end

    def safe_params_for_create
      params.expect(group: [ :name,
                             :description,
                             group_invitations_attributes: [ [ :email_address ] ] ])
    end

    def group
      @group ||= current_user.groups.find_by(id: params[:id])
    end

    def current_user_authorized_for_index? = current_user

    def current_user_authorized_for_show? = group

    def current_user_authorized_for_new? = current_user

    def current_user_authorized_for_create? = current_user
end
