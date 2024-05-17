class BuffetsController < ApplicationController
  before_action :set_buffet, only: %i[show edit update event_types event_selection archive unarchive]
  before_action :is_business_owner?, only: %i[new create edit update]
  before_action :already_has_buffet?, only: %i[new create]
  before_action :client_with_past_confirmed_events, only: %i[show]

  def index
    @buffets = Buffet.where(archived: false)
    params[:search].present? ? @results = search_buffets : @results = []
    @buffets = @buffets.where.not(id: @results.pluck(:id)).order(social_name: :asc)
  end

  def show
  end

  def new
    @buffet = Buffet.new
  end

  def create
    @buffet = Buffet.new(buffet_params)
    @buffet.user = current_user
    if @buffet.save
      redirect_to @buffet
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @buffet.update(buffet_params)
      redirect_to @buffet
    else
      render :edit
    end
  end

  def event_types
    if user_signed_in? && current_user.business_owner? && current_user.buffet == @buffet
      @event_types = EventType.where(buffet: @buffet).order(:name)
    else
      @event_types = EventType.where(buffet: @buffet).where(archived: false).order(:name)
    end
  end

  def event_selection
    @event_types = EventType.where(buffet: @buffet).order(:name)
    if @event_types.empty?
      flash[:notice] = "Este Buffet ainda não possui nenhum evento cadastrado"
      redirect_to @buffet
    end
  end

  def archive
    @buffet.update_attribute(:archived, true)
    flash[:notice] = 'Buffet desativado!'
    redirect_to @buffet
  end

  def unarchive
    @buffet.update_attribute(:archived, false)
    flash[:notice] = 'Buffet reativado!'
    redirect_to @buffet
  end

  private

  def client_with_past_confirmed_events
    current_user_confirmed_events = @buffet.orders.where(user: current_user).where(status: 2).filter { |order| order.event_date < Date.today }
    if current_user_confirmed_events.any?
      if @buffet.ratings.where(user: current_user).any?
        @show_rate_now_alert = false
      else
        @show_rate_now_alert = true
      end
    end
  end

  def search_buffets
    query = params[:search].downcase

    found_buffets = @buffets.where("LOWER(social_name) LIKE :query OR LOWER(city) LIKE :query", query: "%#{query}%")

    if found_buffets.exists?
      @results = found_buffets.order(social_name: :asc)
    else
      query_as_sym = query.to_sym

      buffet_ids = EventType.where("LOWER(name) LIKE ?", "%#{query}%").pluck(:buffet_id)
      @results = @buffets.where(id: buffet_ids).order(social_name: :asc)
    end
  end

  def already_has_buffet?
    if current_user.buffet.present?
      flash[:notice] = 'Você já possui um Buffet cadastrado!'
      return redirect_to root_path
    end
  end

  def is_business_owner?
    redirect_to root_path unless current_user && current_user.business_owner?
  end

  def set_buffet
    @buffet = Buffet.find(params[:id])
  end

  def buffet_params
    params.require(:buffet).permit(
      :social_name,
      :corporate_name,
      :company_registration_number,
      :phone,
      :email,
      :address,
      :neighborhood,
      :city,
      :state,
      :zip_code,
      :description,
      :events_per_day,
      payment_method_ids: []
    )
  end
end
