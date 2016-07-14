class Manage::PermissionsController < Manage::ApplicationController

  load_and_authorize_resource

  def create
    @permission = Permission.create(permission_params)
    render partial: 'manage/angular/permission', locals: { permission: @permission }
  end

  def destroy
    render json: !!Permission.find(params[:id]).destroy
  end

  private
  def permission_params
    params.require(:permission).permit(:number, :user_id, :role, :context_type, :context_id)
  end

end
