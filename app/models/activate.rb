module Activate
  class Application < Rails::Application
    config.action_mailer.delivery_method = :smtp

    config.action_mailer.smtp_settings = {
      address:              'smtp.sendgrid.net',
      port:                 '587',
      domain:               'example.com',
      user_name:            'api_key',
      password:             ENV["SENDGRID_API_KEY"],
      authentication:       'plain',
      enable_starttls_auto: true
    }
  end
end
