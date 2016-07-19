class Manage::DissertationCouncilsController < Manage::ApplicationController
  load_and_authorize_resource

  def index
    @dissertation_councils = @dissertation_councils.includes(:clerks).all
    render partial: 'manage/angular/councils', locals: { councils: @dissertation_councils}
  end

  def show
    render partial: 'manage/angular/council', locals: { council: @dissertation_council }
  end

  def create
    if @dissertation_council.save
      render partial: 'manage/angular/council', locals: { council: @dissertation_council }
    else
      render json: :false
    end
  end

  def destroy
    render json: !!@dissertation_council.destroy
  end

  private

  def dissertation_council_params
    params.require(:dissertation_council).permit(:number)
  end

end
