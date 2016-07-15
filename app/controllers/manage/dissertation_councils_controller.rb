class Manage::DissertationCouncilsController < Manage::ApplicationController
  load_and_authorize_resource

  before_action :set_dissertation_council, only: [:destroy, :update, :show]

  def index
    @councils = DissertationCouncil.includes(:clerks).all
    render partial: 'manage/angular/councils', locals: { councils: @councils}
  end

  def show
    render partial: 'manage/angular/council', locals: { council: @dissertation_council }
  end

  def create
    @dissertation_council = DissertationCouncil.create(dissertation_council_params)
    render partial: 'manage/angular/council', locals: { council: @dissertation_council }
  end

  def update
    if @dissertation_council.update(dissertation_council_params)
      redirect_to [:manage, @dissertation_council], notice: 'Диссертационный совет изменён'
    else
      render :edit
    end
  end

  def destroy
    render json: (@dissertation_council.destroy ? :ok : :false )
  end

  private

  def set_dissertation_council
    @dissertation_council = DissertationCouncil.includes(:clerks).find(params[:id])
  end

  def dissertation_council_params
    params.require(:dissertation_council).permit(:number)
  end

end
