class SquaresController < ApplicationController

  def index
      render :text => "squares = #{Square.includes(:user).to_json()}"
  end

end
