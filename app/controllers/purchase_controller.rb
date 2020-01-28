class PurchaseController < ApplicationController
  before_action :set_product

  def show
    card = Card.where(user_id: current_user.id).first
    if card.blank?
      redirect_to controller: "cards", action: "new"
    else
      @image = Image.where(product_id: @product)
      Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

  def pay
    card = Card.where(user_id: current_user.id).first
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    Payjp::Charge.create(
    :amount => @product.price,
    :customer => card.customer_id,
    :currency => 'jpy',
    )
  redirect_to action: 'update'
  end

  def done
    @image = Image.where(product_id: @product)
  end

  def update
    @product.update(buyer_id: current_user.id)
    redirect_to action: 'done'
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end
