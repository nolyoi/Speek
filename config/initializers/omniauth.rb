Rails.application.config.middleware.use OmniAuth::Builder do
  # Developer setting
  provider :developer unless Rails.env.production?
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET']

  # Google
  # provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'],
  # {
  #   scope: 'userinfo.email, userinfo.profile',
  #   prompt: 'select_account',
  #   image_aspect_ratio: 'square',
  #   image_size: 50
  # }

  # Facebook
  # provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']

  # Twitter
  # provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
end