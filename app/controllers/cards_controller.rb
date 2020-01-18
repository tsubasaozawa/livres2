class CardsController < ApplicationController
  # def show
  #   card = Card.where(user_id: current_user.id).first
  #   if card.blank?
  #     redirect_to controller: "card", action: "new"
  #   else
  #     @product = Product.find(params[:id])
  #     @image = Image.where(product_id: @product )
  #     @freights = Freight.find_by product_id: @product
  #   if @freights.freight == 1
  #     @freight = "送料込み(出品者負担)"
  #   else
  #     @freight = "着払い(購入者負担)"
  #   end
  #     Payjp.api_key = ENV['PAYJP_ACCESS_KEY']
  #     customer = Payjp::Customer.retrieve(card.customer_id)
  #     @default_card_information = customer.cards.retrieve(card.card_id)
  #   end
  # end

  def pay
    @product = Product.find(params[:id])
    card = Card.where(user_id: current_user.id).first
    Payjp.api_key = ENV['PAYJP_ACCESS_KEY']
    Payjp::Charge.create(
    :amount => @product.price,
    :customer => card.customer_id,
    :currency => 'jpy',
    )
  redirect_to action: 'update'
  end

  # def done
  #   @product = Product.find(params[:id])
  #   @image = Image.where(product_id: @product )
  #   @freights = Freight.find_by product_id: @product
  #   if @freights.freight == 1
  #     @freight = "送料込み(出品者負担)"
  #   else
  #     @freight = "着払い(購入者負担)"
  #   end
  # end

  # def update
  #   @product = Product.find(params[:id])
  #   @product.update(buyer_id: current_user.id)
  #   redirect_to action: 'done'
  # end
end
