class EventTypesController < ApplicationController
  before_action :set_event_type, only: [:edit, :update]
  
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

  def remove_picture
    @picture = ActiveStorage::Attachment.find(params[:picture_id])
    @picture.purge
    set_event_type
    redirect_to edit_event_type_path(@event_type)
  end

  private

  def set_event_type
    @event_type = EventType.find(params[:id])
  end

  def event_type_params
    params.require(:event_type).permit(
      :category, 
      :name, 
      :description, 
      :minimal_people_capacity, 
      :maximal_people_capacity, 
      :default_duration_minutes, 
      :food_menu, 
      :alcoholic_drinks, 
      :decoration, 
      :parking_service, 
      :location_flexibility, 
      :base_price, 
      :weekend_fee, 
      :per_person_fee, 
      :per_person_weekend_fee, 
      :per_hour_fee, 
      :per_hour_weekend_fee, 
      pictures: []
    )
  end
end
