require 'date'
class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy, :delete_team_from_booking, :exit_free_booking]
  before_action :authenticate
  before_action :owned, only: [:edit]

  def index
    @bookings = current_user.bookings
    @team_bookings = current_user_team_bookings
  end

  def current_user_team_bookings
    team_bookings = []
    current_user.teams.pluck(:id).each do |team_id|
      team_bookings.concat(Booking.where(away_team: team_id))
    end
    return team_bookings
  end

  def show
  end

  def new
    @booking = Booking.new
    @sports = Sport.all
  end

  def new_team
    @booking = Booking.new
    @sports = Sport.all
    render :new
  end

  def edit
  end

  def create
    if new_booking_params_sended?
      sport_installation = SportsInstallation.where(sport_id: params[:sport], installation_id: params[:installation]).first
      @booking = current_user.bookings.new(sports_installation_id: sport_installation.id, time_band_id: params[:time_band_id])
      if @booking.save
        redirect_to bookings_path, notice: "Booking was successfully created"
      else
        redirect_to :new
      end
    else
      redirect_to new_booking_path, alert: "Make you sure you have selected a sport, a installation and a time band..."
    end
  end

  def exit_free_booking
    participants = @booking.participants.split(',')
    if @booking.user_id == current_user.id
      @booking.destroy
      respond_to do |format|
        format.html { redirect_to bookings_path, notice: 'Booking was destroyed.' }
        format.json { head :no_content }
      end
    else
      participants.delete(current_user.dni)
      @booking.update(participants: participants.join(','))
      respond_to do |format|
        format.html { redirect_to bookings_path, notice: 'You were succesfully removed from the booking.' }
        format.json { head :no_content }
      end
    end
  end

  def update
    time_band_id = @booking.time_band_id
    respond_to do |format|
      if new_booking_params_sended? && @booking.update(time_band_id: params[:time_band_id])
        SportsInstallationsTimeBand.where(time_band_id: time_band_id, sports_installation_id: @booking.sports_installation_id).first.update(free: true)
        format.html { redirect_to @booking, notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit, notice: "Make you sure you have selected a sport, a installation and a time band..." }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_team
    if new_team_booking_params_sended?
      sport_installation = SportsInstallation.where(sport_id: params[:sport], installation_id: params[:installation]).first
      @booking = current_user.bookings.new(sports_installation_id: sport_installation.id, time_band_id: params[:time_band_id], local_team: params[:team_id])
      if @booking.save
        redirect_to bookings_path, notice: "Team Booking was successfully created"
      else
        redirect_to :new
      end
    else
      redirect_to new_team_bookings_path, alert: "Make you sure you have selected a sport, a installation, a team and a time band..."
    end
  end

  def set_team_id
    respond_to do |format|
      format.js
    end
  end

  def join_team_booking
    @sports = Sport.all
  end

  def add_team_to_existing
    if add_team_to_existing_booking_params_sended?
      Booking.find(params[:booking_id]).update(away_team: params[:team_id])
      redirect_to bookings_path, notice: "Your team was successfully added to the booking..."
    else
      redirect_to join_team_booking_bookings_path, alert: "Make you sure you have selected a booking and a team..."
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
    @time_bands = SportsInstallation.where(installation_id: params[:installation_id], sport_id: params[:sport_id]).first.time_bands.where(date: extract_date_from_params)
    @sports_installation = SportsInstallation.where(installation_id: params[:installation_id], sport_id: params[:sport_id]).first
    respond_to do |format|
      format.js
    end
  end

  def delete_team_from_booking
    if @booking.local_team != -1
      if current_user.id == Team.find_by_id(@booking.local_team).user_id
        @booking.destroy
        respond_to do |format|
          format.html { redirect_to bookings_path, notice: 'Booking was  destroyed.' }
          format.json { head :no_content }
        end
      end
    else
      if @booking.away_team != -1
        if current_user.id == Team.find_by_id(@booking.away_team).user_id
          @booking.update(away_team: -1)
          respond_to do |format|
            format.html { redirect_to bookings_url, notice: 'Your team was succesfully removed from the booking.' }
            format.json { head :no_content }
          end
        end
      end
    end
  end

  def team_bookings
    @sports_installation = SportsInstallation.where(installation_id: params[:installation_id], sport_id: params[:sport_id]).first
    @team_bookings = Booking.open_team_booking.where(sports_installation: @sports_installation).where.not(user: current_user).date(extract_date_from_params)
    respond_to do |format|
      format.js
    end
  end

  def extract_date_from_params
    return Date.new(params[:date].split(",")[1].to_i, Date::MONTHNAMES.index(params[:date].split(",")[0].split(" ")[1]).to_i, params[:date].split(",")[0].split(" ")[0].to_i)
  end

  def new_booking_params_sended?
    return (params[:date] and params[:sport] != "" and params[:installation] != "" and params[:time_band_id]) ? true : false
  end

  def new_team_booking_params_sended?
    return new_booking_params_sended? && (params[:team_id] != "")
  end

  def add_team_to_existing_booking_params_sended?
    params[:booking_id] != "" && params[:team_id] != ""
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:sports_installation, :time_band)
  end

  def owned
    if @booking.owned_by?(current_user)
      true
    else
      redirect_to bookings_path, alert: "You don't own the requested booking."
      false
    end
  end

  protected :extract_date_from_params, :new_booking_params_sended?, :new_team_booking_params_sended?, :new_team_booking_params_sended?, :owned
  private :set_booking
end
