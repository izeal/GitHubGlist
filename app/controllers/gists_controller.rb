class GistsController < ApplicationController
  before_action :find_gist, only: [:show]
  before_action :authenticate_user!, except: [
    :show, :index, :resently_created, :least_resently_created,
    :resently_updated, :least_resently_updated, :popular
  ]
  before_action :set_current_user_gist, only: [:edit, :update, :destroy]
  before_action :pincode_guard!, only:[:show]

  def index
    @gists = Gist.paginate(:page => params[:page], :per_page => 5).created_at_desc
  end

  def show
    @comments = @gist.comments.select(&:persisted?)
    @new_comment = @gist.comments.build(params[:comment])
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
    @gist.destroy!
    redirect_to user_path(user), notice: t('controllers.gists.destroyed')
  end

  def upvote
    @gist = Gist.find(params[:gist_id])
    unless current_user.voted_for?(@gist)
      star = @gist.stars.create!(user_id: current_user.id)
      render :show
      GistMailer.star(star).deliver_now unless current_user == @gist.user
    else
      redirect_to gist_path(@gist), alert: t('controllers.gists.alert')
    end
  end

  def downvote
    @gist = Gist.find(params[:gist_id])
    star = Star.find_by(user_id: current_user.id)
    unless star.blank?
      star.destroy!
      render :show
    else
      redirect_to gist_path(@gist), alert: t('controllers.gists.alert')
    end
  end

  def resently_created
    @gists = gists_paginate.created_at_desc
    render :index
  end

  def least_resently_created
    @gists = gists_paginate.created_at_asc
    render :index
  end

  def resently_updated
    @gists = gists_paginate.updated_at_desc
    render :index
  end

  def least_resently_updated
    @gists = gists_paginate.updated_at_asc
    render :index
  end

  def popular
    @gists = gists_paginate.popular
    render :index
  end

  private

  def find_gist
    @gist = Gist.find(params[:id])
  end

  def gist_params
    params.require(:gist).permit(:description, :body, :pincode)
  end

  def set_current_user_gist
    @gist = current_user.gists.find_by(id: params[:id])
    reject_user if @gist.nil?
  end

  def pincode_guard!
    return true if @gist.pincode.blank?
    return true if @gist.user == current_user

    if current_user
      if params[:pincode] && @gist.pincode_valid?(params[:pincode])
        cookies.permanent["gists_#{@gist.id}_pincode"] = params[:pincode]
      end

      unless @gist.pincode_valid?(cookies.permanent["gists_#{@gist.id}_pincode"])
        flash.now[:alert] = t('controllers.gists.pin_alert') if params[:pincode]
        render 'pincode_form'
      end
    else
      redirect_to new_user_session_path, notice: t('controllers.gists.redirect')
    end
  end

  def gists_paginate
    Gist.paginate(:page => params[:page], :per_page => 5)
  end
end
