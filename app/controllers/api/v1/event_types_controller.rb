class Api::V1::EventTypesController < Api::V1::ApiController

  def available
    @order = Order.new(query_params)
    if @order.valid?
      render status: 200, json: @order.as_json(only: [:event_date, :guests_estimation], methods: :event_price)
    else
      render status: 422, json: @order.errors.full_messages
    end
  end

  private

  def query_params
    params.require(:order).permit(:event_type_id, :event_date, :guests_estimation)
  end
end
