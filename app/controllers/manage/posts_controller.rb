class Manage::PostsController < Manage::ApplicationController
  load_and_authorize_resource
  def destroy
    render json: !!Post.find(params[:id]).destroy
  end
end
