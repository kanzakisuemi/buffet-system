class EventTypesController < ApplicationController
  before_action :set_event_type, only: %i[edit update archive unarchive]
  before_action :is_business_owner?, only: %i[new create edit update]
  
  def new
    @event_type = EventType.new
  end

  def create
    @event_type = EventType.new(event_type_params)
    @event_type.buffet = current_user.buffet

    if @event_type.save
      redirect_to event_types_buffet_path(@event_type.buffet)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @event_type.update(event_type_params)
      redirect_to event_types_buffet_path(@event_type.buffet)
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

  def archive
    @event_type.update_attribute(:archived, true)
    flash[:notice] = 'Tipo de evento desativado!'
    redirect_to event_types_buffet_path(@event_type.buffet)
  end

  def unarchive
    @event_type.update_attribute(:archived, false)
    flash[:notice] = 'Tipo de evento reativado!'
    redirect_to event_types_buffet_path(@event_type.buffet)
  end

  private

  def is_business_owner?
    redirect_to root_path unless current_user && current_user.business_owner?
  end

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
