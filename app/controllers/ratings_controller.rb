class RatingsController < ApplicationController
  before_action :set_buffet, only: %i[new create index]
  before_action :client_can_create_rating?, only: %i[new create]

  def index
  end

  def new
    @rating = Rating.new()
  end

  def create
    @rating = Rating.new(rating_params)
    @rating.user = current_user
    @rating.buffet = @buffet
    if @rating.save
      flash[:notice] = 'Avaliação enviada com sucesso!'
      redirect_to buffet_path(@rating.buffet)
    else
      flash.now[:notice] = 'Não foi possível enviar sua avaliação.'
      render 'new'
    end
  end

  private

  def client_can_create_rating?
    if user_signed_in? && current_user.client?
      if @buffet.orders.where(user: current_user).where(status: 2).filter { |order| order.event_date < Date.today }.any?
        if @buffet.ratings.where(user: current_user).any?
          return redirect_to root_path
        else
          return
        end
      end
      flash[:notice] = 'Você não pode avaliar um buffet sem ter feito um evento com ele.'
      redirect_to root_path
    elsif user_signed_in? && current_user.business_owner?
      flash[:notice] = 'Você não pode avaliar um buffet.'
      redirect_to root_path
    else
      flash[:notice] = 'Você precisa estar logado para avaliar um buffet.'
      redirect_to new_user_session_path
    end
  end

  def set_buffet
    @buffet = Buffet.find(params[:buffet_id])
  end

  def rating_params
    params.require(:rating).permit(:score, :review, :buffet_id, :user_id)
  end
end
