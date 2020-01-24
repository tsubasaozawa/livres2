class MessagesController < ApplicationController
  def show
    @product = Product.find(params[:id])
    @messages = @product.messages.includes(:user).order(created_at: "desc")
  end

  def create
    @message = Message.create(message: message_params[:message], product_id: message_params[:product_id], user_id: current_user.id)
    if @message.save
      respond_to do |format|
        # format.html {redirect_to product_message_path, notice: 'メッセージが送信されました'}
        format.json
      end
      #  redirect_to product_message_path   #コメントと結びつく投稿詳細画面に遷移する
    else
      #  @messages = @product.messages.includes(:user)
      #  flash.now[:alert] = 'メッセージを入力してください。'
      #  render "/products/#{@message.product.id}"
    end
  end

  private
  def message_params
    params.permit(:message, :product_id)
  end
end
