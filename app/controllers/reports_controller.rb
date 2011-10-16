class ReportsController < ApplicationController
  
  def create
    respond_to do |format|
      format.js do
        if current_user
          square = Square.find_by_dailymotion_id(params[:video_id])
          if !Report.find_by_square_id_and_user_id(square.id, current_user.id)
            current_user.reports.create :square => square
            render :json => 'created'
          else
            render :json => 'found'
          end
        end
      end
    end
  end
  
end
