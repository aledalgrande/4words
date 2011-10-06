class SquaresController < ApplicationController

  def index
    render :text => "squares = #{Square.includes(:user).to_json()}"
  end
  
  def takeover
    if current_user
      unless current_user.square
        square = Square.find(params[:square_id])
        if square
          current_user.square = square
          square.update_attribute(:html, params[:video_embed_html])
        end
      end
    end
    redirect_to root_path
  end

end
