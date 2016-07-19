class Manage::PostsController < Manage::ApplicationController
  load_and_authorize_resource

  def destroy
    render json: !!@post.destroy
  end
end
