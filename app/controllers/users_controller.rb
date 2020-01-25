class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, except: [:edit]
  before_action :like_users, only: [:show, :bought_products, :sold_products]
  

  def show
    @saling_products = User.find(params[:id]).saling_products

  end

  def bought_products
    @bought_products = User.find(params[:id]).buyed_products
  end

  def sold_products
    @sold_products = User.find(params[:id]).sold_products
  end

  def edit
    @user = User.find(params[:user_id])
    render "users/#{params[:name]}", locals: {user: current_user}
  end

  def update
    if current_user.update(user_params)
      redirect_back(fallback_location: root_path, notice: "更新が完了しました")
    else
      render :edit
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def like_users
    @liked_users = @user.liked_products.pluck(:saler_id).uniq
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
