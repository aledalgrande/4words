class SquaresController < ApplicationController

  def index
    render :text => "squares = #{Square.includes(:user).to_json()}"
  end
  
  def takeover
    if current_user
      unless current_user.square
        square = Square.find(params[:square_id])
        if square && square.user_id.nil? && params[:video_embed_html] && params[:dailymotion_id]
          current_user.square = square
          square.update_attributes(:html => params[:video_embed_html], :dailymotion_id => params[:dailymotion_id])
          @graph = Koala::Facebook::API.new(current_user.token)
          @graph.put_wall_post('we will save Africa')
        end
      end
    end
    redirect_to root_path
  end
  
  def free
    if current_user
      current_user.square = nil
    end
    redirect_to root_path
  end

end