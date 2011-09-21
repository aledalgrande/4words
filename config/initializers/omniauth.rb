Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['APP_ID'], ENV['APP_SECRET'], :scope => 'offline_access,publish_stream,user_hometown'
end