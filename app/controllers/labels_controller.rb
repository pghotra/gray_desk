class LabelsController < ApplicationController
  def index
    @labels = Label.all
  end

  def new
    @label = Label.new
  end

  def create
    @label = Label.create(params[:label])

    if @label.persisted?
      flash[:notice] = "Label #{@label.name} created successfully"
      redirect_to action: :index
    else
      flash[:error] = "Unable to create label"
      redirect_to action: :new
    end
  end
end
