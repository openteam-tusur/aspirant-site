class Manage::DissertationCouncilsController < Manage::ApplicationController

  load_and_authorize_resource

  before_action :set_dissertation_council, only: [:show, :edit, :update, :destroy]

  def index
    @dissertation_councils = DissertationCouncil.ordered
  end

  def show
  end

  def new
    @dissertation_council = DissertationCouncil.new
  end

  def edit
  end

  def create
    @dissertation_council = DissertationCouncil.new(dissertation_council_params)

    if @dissertation_council.save
      redirect_to [:manage, @dissertation_council], notice: 'Диссертационный совет создан'
    else
      render :new
    end
  end

  def update
    if @dissertation_council.update(dissertation_council_params)
      redirect_to [:manage, @dissertation_council], notice: 'Диссертационный совет изменён'
    else
      render :edit
    end
  end

  def destroy
    @dissertation_council.destroy
    redirect_to manage_dissertation_councils_url, notice: 'Диссертационный совет удалён'
  end

  private

    def set_dissertation_council
      @dissertation_council = DissertationCouncil.find(params[:id])
    end

    def dissertation_council_params
      params.require(:dissertation_council).permit(:number)
    end

end
