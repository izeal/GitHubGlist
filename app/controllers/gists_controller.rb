class GistsController < ApplicationController
  before_action :find_gist, only: [:show]
  before_action :authenticate_user!, except: [
    :show, :index, :resently_created, :least_resently_created,
    :resently_updated, :least_resently_updated
  ]
  before_action :set_current_user_gist, only: [:edit, :update, :destroy]
  # проверять свой ли гист редактирует и удаляет юзер

  def index
    @gists = Gist.paginate(:page => params[:page], :per_page => 5).created_at_desc
  end

  def show
    @new_comment = @gist.comments.build(params[:comment])
    @comments = @gist.comments.select(&:persisted?)
  end

  def new
    @gist = current_user.gists.build
  end

  def edit
  end

  def create
    @gist = current_user.gists.build(gist_params)

    if @gist.save
      redirect_to @gist, notice: t('controllers.gists.created')
    else
      render :new
    end
  end

  def update
    if @gist.update(gist_params)
      redirect_to @gist, notice: t('controllers.gists.updated')
    else
      render :edit
    end
  end

  def destroy
    user = @gist.user
    @gist.destroy
    redirect_to user_path(user), notice: t('controllers.gists.destroyed')
  end


  def resently_created
    @gists = Gist.paginate(:page => params[:page], :per_page => 5).created_at_desc
    render :index
  end

  def least_resently_created
   @gists = Gist.paginate(:page => params[:page], :per_page => 5).created_at_asc
    render :index
  end

  def resently_updated
    @gists = Gist.paginate(:page => params[:page], :per_page => 5).updated_at_desc
    render :index
  end

  def least_resently_updated
    @gists = Gist.paginate(:page => params[:page], :per_page => 5).updated_at_asc
    render :index
  end

  private

  def find_gist
    @gist = Gist.find(params[:id])
  end

  def gist_params
    params.require(:gist).permit(:description, :body)
  end

  def set_current_user_gist
    @gist = current_user.gists.find(params[:id])
  end
end
