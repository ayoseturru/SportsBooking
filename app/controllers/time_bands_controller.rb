class TimeBandsController < ApplicationController
  before_action :set_time_band, only: [:show, :edit, :update, :destroy]

  # GET /time_bands
  # GET /time_bands.json
  def index
    @time_bands = TimeBand.all
  end

  # GET /time_bands/1
  # GET /time_bands/1.json
  def show
  end

  # GET /time_bands/new
  def new
    @time_band = TimeBand.new
  end

  # GET /time_bands/1/edit
  def edit
  end

  # POST /time_bands
  # POST /time_bands.json
  def create
    @time_band = TimeBand.new(time_band_params)

    respond_to do |format|
      if @time_band.save
        format.html { redirect_to @time_band, notice: 'Time band was successfully created.' }
        format.json { render :show, status: :created, location: @time_band }
      else
        format.html { render :new }
        format.json { render json: @time_band.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /time_bands/1
  # PATCH/PUT /time_bands/1.json
  def update
    respond_to do |format|
      if @time_band.update(time_band_params)
        format.html { redirect_to @time_band, notice: 'Time band was successfully updated.' }
        format.json { render :show, status: :ok, location: @time_band }
      else
        format.html { render :edit }
        format.json { render json: @time_band.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /time_bands/1
  # DELETE /time_bands/1.json
  def destroy
    @time_band.destroy
    respond_to do |format|
      format.html { redirect_to time_bands_url, notice: 'Time band was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time_band
      @time_band = TimeBand.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def time_band_params
      params.require(:time_band).permit(:date)
    end
end
