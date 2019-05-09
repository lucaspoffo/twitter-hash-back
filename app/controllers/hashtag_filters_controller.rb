class HashtagFiltersController < ApplicationController
  before_action :set_hashtag_filter, only: [:show, :update, :destroy]

  # GET /hashtag_filters
  def index
    @hashtag_filters = HashtagFilter.all

    render json: @hashtag_filters
  end

  # GET /hashtag_filters/1
  def show
    render json: @hashtag_filter
  end

  # POST /hashtag_filters
  def create
    @hashtag_filter = HashtagFilter.new(hashtag_filter_params)

    if @hashtag_filter.save
      render json: @hashtag_filter, status: :created, location: @hashtag_filter
    else
      render json: @hashtag_filter.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /hashtag_filters/1
  def update
    if @hashtag_filter.update(hashtag_filter_params)
      render json: @hashtag_filter
    else
      render json: @hashtag_filter.errors, status: :unprocessable_entity
    end
  end

  # DELETE /hashtag_filters/1
  def destroy
    @hashtag_filter.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hashtag_filter
      @hashtag_filter = HashtagFilter.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def hashtag_filter_params
      params.require(:hashtag_filter).permit(:text).reject{|_, v| v.blank?}
    end
end
