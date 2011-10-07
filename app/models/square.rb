class Square < ActiveRecord::Base
  belongs_to :user
  before_save :set_colour, :unset_html
  
  STD_COLOURS = { :taken => 'FFFFFF', :not_taken => '808285' }
  
  def as_json(options=nil)
    {
      :id => id,
      :colour => colour,
      :height => height,
      :taken => taken,
      :user_id => user_id,
      :html => html,
      :width => width,
      :x => x,
      :y => y,
      :name => user_id ? user.name : nil,
      :avatar => user_id ? user.image_url : nil,
      :dailymotion_id => dailymotion_id
    }
  end
  
  def set_colour
    user_id ? self.colour = STD_COLOURS[:taken] : self.colour = STD_COLOURS[:not_taken]
  end
  
  def unset_html
    self.html = nil unless user_id
  end
end
