class Api::V1::BuffetsController < Api::V1::ApiController
  before_action :set_buffet, only: %i[show event_types]
  
  def show
    render status: 200, json: @buffet.as_json(except: [:created_at, :updated_at, :corporate_name, :company_registration_number, :user_id])
  end

  def index
    if params[:search].present?
      query = params[:search].downcase
      @buffets = Buffet.where("LOWER(social_name) LIKE :query OR LOWER(city) LIKE :query", query: "%#{query}%").where(archived: false)
      render status: 200, json: @buffets
    else
      @buffets = Buffet.where(archived: false).order(social_name: :asc)
      render status: 200, json: @buffets
    end
  end

  def event_types
    @event_types = EventType.where(buffet: @buffet).where(archived: false).order(:name)
    render status: 200, json: @event_types.as_json(except: [:created_at, :updated_at])
  end

  private

  def set_buffet
    @buffet = Buffet.find(params[:id])
  end

  # def index
    # @buffets = Buffet.all
    # render status: 200, json: @buffets
    # if params[:search].present?
    #   @results = search_buffets
    #   @buffets = @buffets.where.not(id: @results.pluck(:id)).order(social_name: :asc)
    # else
    #   @results = []
    # end
  # end

  # def search_results
  #   query = params[:search].downcase

  #   found_buffets = @buffets.where("LOWER(social_name) LIKE :query OR LOWER(city) LIKE :query", query: "%#{query}%")

  #   if found_buffets.exists?
  #     @results = found_buffets.order(social_name: :asc)
  #   else
  #     query_as_sym = query.to_sym

  #     if EventType.categories.key?(query_as_sym)
  #       buffet_ids = EventType.where(category: query_as_sym).pluck(:buffet_id)
  #       @results = @buffets.where(id: buffet_ids).order(social_name: :asc)
  #     else
  #       buffet_ids = EventType.where("LOWER(name) LIKE ?", "%#{query}%").pluck(:buffet_id)
  #       @results = @buffets.where(id: buffet_ids).order(social_name: :asc)
  #     end
  #   end
  # end
end
