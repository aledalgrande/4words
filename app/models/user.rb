class User < ActiveRecord::Base
  has_one :square
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.name = auth['user_info']['name']
      user.image_url = auth['user_info']['image']
    end
  end
  
end
