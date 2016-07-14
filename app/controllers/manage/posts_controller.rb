class Manage::PostsController < Manage::ApplicationController
  def destroy
    render json: !!Post.find(params[:id]).destroy
  end
end
