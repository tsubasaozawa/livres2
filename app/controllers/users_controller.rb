class UsersController < ApplicationController

  private

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
