class Manage::PostsController < Manage::ApplicationController
  load_and_authorize_resource

  def update
    @post.update post_params
    render json: @post
  end

  def destroy
    render json: !!@post.destroy
  end

  private

  def post_params
    params.require(:post).permit(:title)
  end
end
