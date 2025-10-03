class GroupsController < ApplicationController
  before_action :redirect_to_new_if_should_on_index, only: %i[ index ]
  before_action :build_group, only: %i[ new create ]
  before_action :set_group, only: %i[ show ]

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
      return unless should_redirect_to_new_on_index?

      redirect_to new_group_path
    end

    def build_group
      @group = Group.new
    end

    def safe_params_for_create
      params.expect(group: [ :name,
                             :description,
                             group_invitations_attributes: [ [ :email_address ] ] ])
    end

    def set_group
      render_403 unless @group = current_user.groups.find_by(id: params[:id])
    end
end
