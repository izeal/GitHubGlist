class GistsController < ApplicationController
  before_action :set_gist, only: [:show]
  before_action :authenticate_user!, except: [:show, :index, :all_list, :past_list]
  before_action :set_current_user_gist, only: [:edit, :update, :destroy]

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
    @gist = Gist.find(params[:id])
  end

  def gist_params
    params.require(:gist).permit(:description, :body)
  end

  def set_current_user_gist
    @gist = current_user.gists.find(params[:id])
  end
end
