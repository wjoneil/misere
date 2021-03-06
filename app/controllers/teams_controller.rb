class TeamsController < AuthenticatedController
  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.where(user_id: current_user.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @teams }
    end
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    @team = Team.where(user_id: current_user.id).find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @team }
    end
  end

  # GET /teams/new
  # GET /teams/new.json
  def new
    @team = Team.new
    @players = Player.where(user_id: current_user.id)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @team }
    end
  end

  # GET /teams/1/edit
  def edit
    @team = Team.where(user_id: current_user.id).find(params[:id])
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(params[:team])
    @team.user = current_user

    params[:players].each do |player|
      @team.players << Player.find(player[:id])
    end

    respond_to do |format|
      if @team.save
        format.html { redirect_to teams_url, notice: 'Team was successfully created.' }
        format.json { render json: @team, status: :created, location: @team }
      else
        @players = Player.where(user_id: current_user.id)
        format.html { render action: "new" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /teams/1
  # PUT /teams/1.json
  def update
    @team = Team.find(params[:id])

    respond_to do |format|
      if @team.update_attributes(params[:team])
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team = Team.where(user_id: current_user.id).find(params[:id])
    @team.destroy
    #TODO: handle destroy failure when team still has games

    respond_to do |format|
      format.html { redirect_to teams_url }
      format.json { head :no_content }
    end
  end
end
