class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  before_action :authenticate

  # GET /teams
  # GET /teams.json
  def index
    array = Array.new

    Team.where(user_id: current_user).each do |f|
      array << f
    end

    current_user.teams.each do |f|
      array << f
    end

    @teams = array.uniq
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  def add_player
    @player = User.find_by_dni(params[:dni])
    #@team.users = @team.users.push @player
    @team.users = @team.users.push(@player)
    #CUIDADO ARRIBA
    respond_to do |format|
      if @player
        format.js
      else
        format.js {
          render "_player_not_found"
        }
      end
    end
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = current_user.teams.new(team_params)
    if @team.save
      redirect_to teams_path, notice: "Booking was successfully created"
    else
      redirect_to :new
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_team
    @team = Team.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def team_params
    params.require(:team).permit(:user_id, :name, :sport)
  end
end
