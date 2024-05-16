class MessagesController < ApplicationController
before_action :set_order, only: %i[start_chat create index]

  def start_chat
    @message = Message.new()
  end

  def create
    @message = Message.new(message_params)
    @message.user = current_user
    @message.order = @order
    if @order.messages.empty?
      if @message.save
        redirect_to order_messages_path(@order)
      else
        render 'start_chat', notice: 'Não foi possível enviar a mensagem.'
      end
    else
      if @message.save
        redirect_to order_messages_path(@order)
      else
        @messages = @order.messages.order(created_at: :asc)
        render 'index'
      end
    end
  end

  def index
    @messages = @order.messages.order(created_at: :asc)
    @message = Message.new
  end

  private 

  def set_order
    @order = Order.find(params[:order_id])
  end

  def message_params
    params.require(:message).permit(:content, :order_id, :user_id)
  end

end
