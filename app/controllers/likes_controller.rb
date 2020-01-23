class LikesController < ApplicationController
  before_action :set_likeID
  def create
    @like = current_user.likes.create(product_id: params[:product_id])
    render 'create-like.js.erb'
  end

  def destroy
    @like = Like.find_by(product_id: params[:product_id], user_id: current_user.id)
    @like.destroy
    render 'delete-like.js.erb'
  end

  private
  def set_likeID
    @product = Product.find(params[:product_id])
    @id_name = "#like-btn-#{@product.id}"
  end
end
