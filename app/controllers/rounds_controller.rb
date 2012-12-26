class RoundsController < ApplicationController
  # GET /games/1/rounds
  # GET /games/1/rounds.json
  def index
    @game = Game.find(params[:game_id])
    @rounds = @game.rounds
    @round = @game.rounds.build

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rounds }
    end
  end

  # GET /games/1/rounds/1
  # GET /games/1/rounds/1.json
  def show
    @game = Game.find(params[:game_id])
    @round = @game.rounds.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @round }
    end
  end

  # GET /games/1/rounds/new
  # GET /games/1/rounds/new.json
  def new
    @game = Game.find(params[:game_id])
    # @new_round = @game.rounds.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @round }
    end
  end

  # GET /games/1/rounds/1/edit
  def edit
    @game = Game.find(params[:game_id])
    @round = @game.rounds.find(params[:id])
  end

  # POST /games/1/rounds
  # POST /games/1/rounds.json
  def create
    @game = Game.find(params[:game_id])
    @round = @game.rounds.build(params[:round])

    @round.determine_scores
    @game.rounds << @round unless @round.invalid?

    @game.determine_winner @round

    respond_to do |format|
      if @game.save
        format.html { redirect_to game_rounds_url(@game), notice: 'Round was successfully created.' }
        format.json { render json: @round, status: :created, location: @round }
      else
        #if the round failed to create, we want to render the index with the failed round
        @rounds = @game.rounds
        format.html { render action: "index" }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /games/1/rounds/1
  # PUT /games/1/rounds/1.json
  def update
    @game = Game.find(params[:game_id])
    @round = @game.rounds.find(params[:id])

    respond_to do |format|
      if @round.update_attributes(params[:round])
        format.html { redirect_to @round, notice: 'Round was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1/rounds/1
  # DELETE /games/1/rounds/1.json
  def destroy
    @game = Game.find(params[:game_id])
    @round = @game.rounds.find(params[:id])
    @round.destroy

    respond_to do |format|
      format.html { redirect_to game_rounds_url(@game), notice: 'Round was successfully deleted.' }
      format.json { head :no_content }
    end
  end
end
