require 'date'
class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  # GET /bookings
  # GET /bookings.json
  def index
    @bookings = Booking.all
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    @booking = Booking.new
    @sports = Sport.all
  end

  # GET /bookings/1/edit
  def edit
  end

  def installation_options
    @installations = Sport.find_by_id(params[:sport_id]).installations
    respond_to do |format|
      format.js
    end
  end

  def free_hours_table
    new_booking_params = filter_booking_params
    if new_booking_params
      @time_bands = SportsInstallation.where(installation_id: params[:installation_id], sport_id: params[:sport_id]).first.time_bands.where(date: Date.new(new_booking_params[:year], new_booking_params[:month], new_booking_params[:day]))
      respond_to do |format|
        format.js
      end
    end
  end

  protected
  def filter_booking_params
    return !new_booking_params_sended? ? false : new_booking_filter_params
  end

  protected
  def new_booking_filter_params
    return {day: params[:date].split(",")[0].split(" ")[0].to_i, month: Date::MONTHNAMES.index(params[:date].split(",")[0].split(" ")[1]).to_i, year: params[:date].split(",")[1].to_i}
  end

  protected
  def new_booking_params_sended?
    return (params[:date] and params[:sport_id] and params[:installation_id]) ? true : false
  end

  # POST /bookings
  # POST /bookings.json
  def create
    @booking = Booking.new(booking_params)

    respond_to do |format|
      if @booking.save
        format.html { redirect_to @booking, notice: 'Booking was successfully created.' }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to @booking, notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to bookings_url, notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_booking
    @booking = Booking.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def booking_params
    params.require(:booking).permit(:sports_installation, :time_band)
  end
end
