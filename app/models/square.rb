class Square < ActiveRecord::Base
  belongs_to :user
  before_save :set_colour, :unset_html
  has_many :votes
  has_many :reports
  
  STD_COLOURS = { :taken => 'FFFFFF', :not_taken => '808285' }
  
  def as_json(options=nil)
    {
      :id => id,
      :h => height,
      :u => user_id,
      :k => html,
      :w => width,
      :x => x,
      :y => y,
      :n => user_id ? user && user.name : nil,
      :d => dailymotion_id
    }
  end
  
  def set_colour
    user_id ? self.colour = STD_COLOURS[:taken] : self.colour = STD_COLOURS[:not_taken]
  end
  
  def unset_html
    self.html = nil unless user_id
  end
end
