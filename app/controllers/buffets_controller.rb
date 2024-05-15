class BuffetsController < ApplicationController
  before_action :set_buffet, only: %i[show edit update event_types event_selection archive]
  before_action :is_business_owner?, only: %i[new create edit update]
  before_action :already_has_buffet?, only: %i[new create]

  def index
    @buffets = Buffet.all
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
    @event_types = EventType.where(buffet: @buffet).order(:name)
  end

  def event_selection
    @event_types = EventType.where(buffet: @buffet).order(:name)
    if @event_types.empty?
      flash[:notice] = "Este Buffet ainda não possui nenhum evento cadastrado"
      redirect_to @buffet
    end
  end

  def archive
    @buffet.archive!
    flash[:notice] = 'Buffet desativado!'
    redirect_to @buffet
  end

  private

  def search_buffets
    query = params[:search].downcase

    found_buffets = @buffets.where("LOWER(social_name) LIKE :query OR LOWER(city) LIKE :query", query: "%#{query}%")

    if found_buffets.exists?
      @results = found_buffets.order(social_name: :asc)
    else
      query_as_sym = query.to_sym

      if EventType.categories.key?(query_as_sym)
        buffet_ids = EventType.where(category: query_as_sym).pluck(:buffet_id)
        @results = @buffets.where(id: buffet_ids).order(social_name: :asc)
      else
        buffet_ids = EventType.where("LOWER(name) LIKE ?", "%#{query}%").pluck(:buffet_id)
        @results = @buffets.where(id: buffet_ids).order(social_name: :asc)
      end
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
