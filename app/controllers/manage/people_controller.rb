class Manage::PeopleController < Manage::ApplicationController
  before_filter :find_context

  attr_accessor :context

  def create
    @person = context.persons.where(person_params).first_or_initialize
    @person.save
    render partial: 'manage/angular/person', locals: { person: @person }
  end

  private

  def find_context
    @context ||= params[:context_type].classify.find(params[:context_id])
  end

  def person_params
    params.require(:person).permit(:name, :surname, :patronymic)
  end
end
