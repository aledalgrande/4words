class SquaresController < ApplicationController

  def index
      render :text => "squares = #{Square.all.to_json(:except => [:created_at, :updated_at])}"
  end

end
