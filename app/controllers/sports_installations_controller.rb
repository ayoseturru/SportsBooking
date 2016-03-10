class SportsInstallationsController < ApplicationController
  before_action :set_sports_installation, only: [:show, :edit, :update, :destroy]

  # GET /sports_installations
  # GET /sports_installations.json
  def index
    @sports_installations = SportsInstallation.all
  end

  # GET /sports_installations/1
  # GET /sports_installations/1.json
  def show
  end

  # GET /sports_installations/new
  def new
    @sports_installation = SportsInstallation.new
  end

  # GET /sports_installations/1/edit
  def edit
  end

  # POST /sports_installations
  # POST /sports_installations.json
  def create
    @sports_installation = SportsInstallation.new(sports_installation_params)

    respond_to do |format|
      if @sports_installation.save
        format.html { redirect_to @sports_installation, notice: 'Sports installation was successfully created.' }
        format.json { render :show, status: :created, location: @sports_installation }
      else
        format.html { render :new }
        format.json { render json: @sports_installation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sports_installations/1
  # PATCH/PUT /sports_installations/1.json
  def update
    respond_to do |format|
      if @sports_installation.update(sports_installation_params)
        format.html { redirect_to @sports_installation, notice: 'Sports installation was successfully updated.' }
        format.json { render :show, status: :ok, location: @sports_installation }
      else
        format.html { render :edit }
        format.json { render json: @sports_installation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sports_installations/1
  # DELETE /sports_installations/1.json
  def destroy
    @sports_installation.destroy
    respond_to do |format|
      format.html { redirect_to sports_installations_url, notice: 'Sports installation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sports_installation
      @sports_installation = SportsInstallation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sports_installation_params
      params.require(:sports_installation).permit(:installation_id, :sport_id)
    end
end
