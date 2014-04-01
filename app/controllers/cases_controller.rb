class CasesController < ApplicationController

  before_filter :assign_case, only: [:edit]

  def index
    @cases = Case.all
  end

  def edit
  end

  def update
    @case = Case.update(params[:id], params[:case])

    if @case.persisted?
      flash[:notice] = "case #{@case.subject} updated successfully"
    else
      flash[:error] = "Unable to update case"
      redirect_to action: :index
    end

    redirect_to action: :index
  end

  private

  def assign_case
    @case = Case.find_by_id params[:id]
  end
end
