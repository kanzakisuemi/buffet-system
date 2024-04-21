class BuffetsController < ApplicationController
  before_action :set_buffet, only: %i[show edit update]

  def index
    @buffets = Buffet.all
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
