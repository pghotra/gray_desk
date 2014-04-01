class CasesController < ApplicationController

  before_filter :assign_case, only: :edit

  def index
    @cases = Case.all
  end

  def edit
  end

  private

  def assign_case
    @case = Case.find_by_id params[:id]
  end
end
