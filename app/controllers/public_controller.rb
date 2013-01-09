class PublicController < ApplicationController

  def index

    if user_signed_in?

      url = if current_user.players.length < 4
        players_url
      elsif current_user.teams.length < 2
        teams_url
      else
        games_url
      end

      redirect_to url
      return
    end

    respond_to do |format|
      format.html # index.html.erb
    end
  end

end
