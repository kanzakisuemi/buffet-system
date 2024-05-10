class OrdersController < ApplicationController
  before_action :is_client?, only: %i[my]
  before_action :is_business_owner?, only: %i[index]
  before_action :set_event_type, only: %i[new create]
  before_action :set_order, only: %i[show edit update canceled confirmed]
  before_action :authenticate_user!, only: %i[new create edit update]
  after_action :cancel_when_proposal_expire, only: %i[my index]

  def my
    @orders = Order.where(user: current_user)
  end

  def index
    @buffet = current_user.buffet 
    @orders = @buffet.orders
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    @order.event_type = @event_type
    if @order.save
      flash[:notice] = 'Pedido cadastrado com sucesso!'
      redirect_to @order
    else
      flash.now[:notice] = 'Não foi possível cadastrar o pedido.'
      render 'new'
    end
  end

  def show
    @same_date_orders = Order.where(event_date: @order.event_date).where.not(id: @order.id)
    @messages = @order.messages
    @message = Message.new
  end

  def edit
  end

  def update
    if @order.update(order_params)
      @order.approved! if current_user.role == 'business_owner'
      flash[:notice] = 'Pedido atualizado com sucesso!'
      redirect_to @order
    else
      flash.now[:notice] = 'Não foi possível atualizar o pedido.'
      render 'edit'
    end
  end

  def confirmed
    @order.confirmed!
    flash[:notice] = 'Pedido confirmado!'
    redirect_to @order
  end

  def canceled
    @order.canceled!
    flash[:notice] = 'Pedido cancelado!'
    redirect_to @order
  end

  private

  def cancel_when_proposal_expire
    approved_orders = @orders.where(status: :approved)
    approved_orders.each do |approved_order|
      if approved_order.due_date?
        approved_order.due_date < Date.today ? approved_order.canceled! : return
      end
    end
  end

  def is_client?
    if user_signed_in? && current_user.role == 'client'
      true
    else
      redirect_to root_path, message: 'Acesso negado.'
    end
  end

  def is_business_owner?
    if user_signed_in? && current_user.role == 'business_owner'
      true
    else
      redirect_to root_path, message: 'Acesso negado.'
    end
  end

  def set_event_type
    @event_type = EventType.find(params[:event_type_id])
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(
      :event_date,
      :guests_estimation,
      :event_details,
      :event_address,
      :status,
      :payment_method_id,
      :grant_discount,
      :charge_fee,
      :extra_fee,
      :discount,
      :budget_details,
      :budget,
      :due_date
    )
  end
end

