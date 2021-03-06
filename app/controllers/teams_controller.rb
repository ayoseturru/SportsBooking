class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  before_action :authenticate

  # GET /teams
  # GET /teams.json
  def index
    @teams = []

    Team.where(user_id: current_user).each do |my_teams_owner|
      @teams.push my_teams_owner
    end

    current_user.teams.each do |my_teams_members|
      @teams.push my_teams_members
    end

    @teams = current_user.teams
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
    access_denied unless @team.user == current_user
  end

  def add_players_from_edit
    @player = User.find_by_dni(params[:dni])
    @team = Team.find_by_id(params[:team_id])
    respond_to do |format|
      if @player and !Team.find_by_id(params[:team_id]).users.include?(@player)
        @team.users.push(@player)
      else
        @player = false
      end
      format.js
    end
  end

  def add_player
    @player = User.find_by_dni(params[:dni])

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
    players_to_save = [@current_user]

    params[:players_list].split(",").each do |id|
      players_to_save.include?(User.find_by_id(id)) ? next : players_to_save.push(User.find_by_id(id))
    end

    @team = current_user.teams.new(team_params)
    @team.user_id = current_user.id
    @team.users = players_to_save

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def remove_player
    @team = Team.find(params[:team_id])
    @team.users.delete(User.find_by_id(params[:player_id]))

    @player_id = params[:player_id]

    respond_to do |format|
      # format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      # format.json { head :no_content }
      format.js
    end
  end

  def leave_team
    @team = Team.find(params[:team_id])
    @team.users.delete(User.find_by_id(params[:player_id]))

    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'You left the team successfully.' }
      format.json { head :no_content }
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

  def delete_image_team
    @team = Team.find_by_id(params[:id])
    if @team != nil
    @team.image = nil
    @team.save
    end
    respond_to do |format|
      format.js
    end
  end

  # SEARCH /teams
  def search
    @teams=Team.where("name LIKE ?", "%#{params[:name]}%")
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_team
    @team = Team.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def team_params
    params.require(:team).permit(:user_id, :name, :sport_id, :image)
  end
end
