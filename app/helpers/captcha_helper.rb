require 'faraday_middleware'

module CaptchaHelper
  def verify_captcha(captcha_response, remote_ip)
    response = @@connection.post 'https://www.google.com/recaptcha/api/siteverify', {
      :secret => Rails.application.secrets.captcha_secret_key,
      :response => captcha_response
      #:remoteip => remote_ip
    }
    logger.info response.body
    return response.body['success']
  end

  private

  @@connection = Faraday.new do |conn|
    conn.use Faraday::Response::Logger, Rails.logger
    conn.request  :url_encoded
    conn.response :json, :content_type => /\bjson$/
    conn.adapter Faraday.default_adapter
  end
end
