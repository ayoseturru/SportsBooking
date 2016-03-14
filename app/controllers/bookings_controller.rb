require 'date'
class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :authenticate

  def index
    @bookings = Booking.all
  end

  def show
  end

  def new
    @booking = Booking.new
    @sports = Sport.all
  end

  def edit
  end

  def create
    if new_booking_params_sended?
      sport_installation = SportsInstallation.where(sport_id: params[:sport], installation_id: params[:installation]).first
      @booking = Booking.new(sports_installation_id: sport_installation.id, time_band_id: params[:time_band_id])
      if @booking.save
        redirect_to bookings_path, notice: "Booking was successfully created"
      else
        redirect_to :new
      end
    else
      redirect_to new_booking_path, alert: "Make you sure you have selected a sport, a installation and a time band..."
    end
  end

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

  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to bookings_url, notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def installation_options
    @installations = Sport.find_by_id(params[:sport_id]).installations
    respond_to do |format|
      format.js
    end
  end

  def free_hours_table
    date = extract_date_from_params
    @time_bands = SportsInstallation.where(installation_id: params[:installation_id], sport_id: params[:sport_id]).first.time_bands.where(date: Date.new(date[:year], date[:month], date[:day]))
    @sports_installation = SportsInstallation.where(installation_id: params[:installation_id], sport_id: params[:sport_id]).first
    respond_to do |format|
      format.js
    end
  end

  def extract_date_from_params
    return {day: params[:date].split(",")[0].split(" ")[0].to_i, month: Date::MONTHNAMES.index(params[:date].split(",")[0].split(" ")[1]).to_i, year: params[:date].split(",")[1].to_i}
  end

  def new_booking_params_sended?
    return (params[:date] and params[:sport] and params[:installation] and params[:time_band_id]) ? true : false
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:sports_installation, :time_band)
  end

  protected :extract_date_from_params, :new_booking_params_sended?
  private :set_booking
end
