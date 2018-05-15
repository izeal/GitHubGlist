class GistsController < ApplicationController
  before_action :set_gist, only: [:show]

  def index
    @gists = Gist.all
  end

  def show
  end

  def new
    @gist = current_user.gists.build
  end

  def edit
  end

  def create
    @gist = current_user.gists.build(gist_params)

    if @gist.save
      redirect_to @gist, notice: I18n.t('controllers.events.created')
    else
      render :new
    end
  end

  def update
    if @gist.update(gist_params)
      redirect_to @gist, notice: I18n.t('controllers.events.updated')
    else
      render :edit
    end
  end

  def destroy
    user = @gist.user
    @gist.destroy
    redirect_to user_path(user), notice: I18n.t('controllers.events.destroyed')
  end

  private

  def set_gist
    @event = Event.find(params[:id])
  end

  def gist_params
    params.require(:gist).permit(:description, :body)
  end
end
