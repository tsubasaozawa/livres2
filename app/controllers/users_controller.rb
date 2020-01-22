class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
    @saling_products = User.find(params[:id]).saling_products
    
    # @like_posts = @user.liked_posts.pluck(:user_id).uniq
    # @users = User.find(@like_posts)
    # @like_users = @users.map { |h| h[:id] }
    # @like_user = @like_users.reject { |n| n == current_user.id }

    # @posts = @user.liked_posts.map { |h| h[:user_id] }
    # @post = @posts.reject { |n| n == current_user.id }
  end

  def bought_products
    @bought_products = User.find(params[:id]).buyed_products
  end

  def sold_products
    @sold_products = User.find(params[:id]).sold_products
  end

  def edit
    
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
    :email,
    :nickname,
    :fullname_kanji,
    :fullname_kana,
    :birthday,
    :tel_number,
    :profile_text,
    :profile_image,
    :current_address_postal_code,
    :current_address_prefectures,
    :current_address_city,
    :current_address_,
    :current_address_building,
    )
  end
end
