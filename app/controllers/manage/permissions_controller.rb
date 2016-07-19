class Manage::PermissionsController < Manage::ApplicationController
  load_and_authorize_resource

  def index
    render partial: 'manage/angular/permissions', locals: { permissions: @permissions }
  end

  def create
    if @permission.save
      render partial: 'manage/angular/permission', locals: { permission: @permission }
    else
      render json: :false
    end
  end

  def destroy
    render json: !!@permission.destroy
  end

  private
  def permission_params
    params.require(:permission).permit(:number, :user_id, :role, :context_type, :context_id)
  end

end
