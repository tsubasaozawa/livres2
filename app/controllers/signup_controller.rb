class SignupController < ApplicationController
  require "payjp"
  before_action :set_card, except: [:step1, :step2, :step3, :create, :done]
  before_action :save_step1_to_session, only: :step2
  before_action :save_step2_to_session, only: :step3
  def step1
    @user = User.new
    @user.build_cards
    # if session["devise.provider_data"] != nil
    #   @snsusername = session["devise.provider_data"]["info"]["name"]
    #   @snsuseremail = session["devise.provider_data"]["info"]["email"]
    # end
  end

  def save_step1_to_session
    params[:user][:birthday] = birthday_join
    session[:user_params_after_step1] = user_params
    @user = User.new(session[:user_params_after_step1])
    render '/signup/step1' unless @user.valid?(:save_step1_to_session)
  end

  def step2
    @user = User.new
  end

  def save_step2_to_session
    session[:user_params_after_step2] = user_params
    session[:user_params_after_step2].merge!(session[:user_params_after_step1])
    @user = User.new(session[:user_params_after_step2])
    render '/signup/step2' unless @user.valid?(:save_step2_to_session)
  end

  def step3
    # @user = User.new
  end

  def create
    @user = User.new(session[:user_params_after_step2])
    # if session["devise.provider_data"] != nil
    #   @user.uid = session["devise.provider_data"]["uid"]
    #   @user.provider = session["devise.provider_data"]["provider"]
    # end

    Payjp.api_key = ENV['PAYJP_ACCESS_KEY']
    if params['payjp-token'].blank?
      redirect_to action: "step4"
    else
      customer = Payjp::Customer.create(
        description: 'test', 
        card: params['payjp-token'], 
        metadata: :user_id
      )
    end
    if @user.save
      @card = Card.new(user_id: @user.id, customer_id: customer.id, card_id: customer.default_card)
      session[:id] = @user.id
      if @card.save
        redirect_to controller: :signup, action: :done
      else
        render '/signup/step3'
      end
    else
      render '/signup/step1'
    end
    
  end

  def done
    sign_in User.find(session[:id]) unless user_signed_in?
    redirect_to root_path
  end

  private
    def user_params
      params.require(:user).permit(
        :nickname,
        :fullname_kanji,
        :fullname_kana,
        :birthday,
        :email,
        :password,
        :password_confirmation,
        :current_address_postal_code,
        :current_address_prefectures,
        :current_address_city,
        :current_address,
        :current_address_building,
        :tel_number,
      )
    end

    def birthday_join
      date = params[:birthday]
      if date["birthday(1i)"].empty? && date["birthday(2i)"].empty? && date["birthday(3i)"].empty?
        return
      end
      Date.new date["birthday(1i)"].to_i,date["birthday(2i)"].to_i,date["birthday(3i)"].to_i
    end

    def set_card
      @card = Cards.where(user_id: current_user.id).first if Cards.where(user_id: current_user.id).present? # いる、これ？
    end
end
