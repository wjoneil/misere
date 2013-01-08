class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def after_sign_in_path_for(resource)
   return players_path if current_user.players.length < 4
   return teams_path if current_user.teams.length < 2
   games_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end
end
