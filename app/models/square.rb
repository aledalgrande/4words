class Square < ActiveRecord::Base
  belongs_to :user
  before_save :set_colour
  
  STD_COLOURS = { :taken => 'FFFFFF', :not_taken => '808285' }
  
  def as_json(options=nil)
    {
      :id => id,
      :colour => colour,
      :height => height,
      :taken => taken,
      :user_id => user_id,
      :video_url => video_url,
      :width => width,
      :x => x,
      :y => y,
      :name => user ? user.name : nil,
      :avatar => user ? user.image_url : nil
    }
  end
  
  def set_colour
    user_id ? self.colour = STD_COLOURS[:taken] : self.colour = STD_COLOURS[:not_taken]
  end
end
