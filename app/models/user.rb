class User < ActiveRecord::Base
  has_one :square
  has_many :votes
  has_many :reports
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.name = auth['user_info']['name']
      user.image_url = auth['user_info']['image']
      user.token = auth['credentials']['token']
    end
  end
  
end
