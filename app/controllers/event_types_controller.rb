class EventTypesController < ApplicationController
  before_action :set_event_type, only: [:edit, :update, :destroy]
  
  def index
    @event_types = EventType.all
  end

  def new
    @event_type = EventType.new
  end

  def create
    @event_type = EventType.new(event_type_params)
    @event_type.buffet = current_user.buffet

    if @event_type.save
      redirect_to event_types_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @event_type.update(event_type_params)
      redirect_to event_types_path
    else
      render :edit
    end
  end

  def destroy
    @event_type.destroy
    redirect_to event_types_path
  end

  private

  def set_event_type
    @event_type = EventType.find(params[:id])
  end

  def event_type_params
    params.require(:event_type).permit(:category, :name, :description, :minimal_people_capacity, :maximal_people_capacity, :default_duration_minutes, :food_menu, :alcoholic_drinks, :decoration, :parking_service, :location_flexibility)
  end
end
