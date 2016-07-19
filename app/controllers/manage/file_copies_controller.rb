class Manage::FileCopiesController < Manage::ApplicationController
  authorize_resource

  before_filter :find_context, only: :create

  def create
    @file = FileCopy.new(file_params)
    @file.context = @context
    @file.save
    render partial: 'manage/angular/file_copy', locals: { file: @file }
  end

  def update
    @file = FileCopy.find(params[:id])
    if @file.update(file_params)
      render partial: 'manage/angular/file_copy', locals: { file: @file }
    else
      render json: :false
    end
  end

  def destroy
    render json: FileCopy.find(params[:id]).destroy
  end

  private
  def file_params
    params.require(:file_copy).permit(:file, :placement_date, :kind, :person_id)
  end

  def find_context
    @context = params[:context_type]
                .constantize
                .find params[:context_id]
  end
end
