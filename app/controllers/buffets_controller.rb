class BuffetsController < ApplicationController
  before_action :set_buffet, only: %i[show edit update]

  def index
    @buffets = Buffet.all
    @results = []

    if params[:search].present?
      query = params[:search].downcase

      found_buffets = @buffets.where("LOWER(social_name) LIKE :query OR LOWER(city) LIKE :query", query: "%#{query}%")

      if found_buffets.exists?
        @results = found_buffets.order(social_name: :asc)
      else
        query_as_sym = query.to_sym

        if EventType.categories.key?(query_as_sym)
          buffet_ids = EventType.where(category: query_as_sym).pluck(:buffet_id)
          @results = @buffets.where(id: buffet_ids)
        else
          buffet_ids = EventType.where("LOWER(name) LIKE ?", "%#{query}%").pluck(:buffet_id)
          @results = @buffets.where(id: buffet_ids)
        end
      end

      @buffets = @buffets.where.not(id: @results.pluck(:id))
    end
  end

  def show
  end

  def new
    # @payment_methods = PaymentMethod.all
    @buffet = Buffet.new
  end

  def create
    @buffet = Buffet.new(buffet_params)
    @buffet.user = current_user
    if @buffet.save
      redirect_to @buffet
    else
      # @payment_methods = PaymentMethod.all
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

  private

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
      payment_method_ids: []
    )
  end
end
