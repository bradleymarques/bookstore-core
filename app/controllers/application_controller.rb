class ApplicationController < ActionController::Base
  AUTH_HEADER = "HTTP_AUTHORIZATION"
  BEARER = "Bearer "

  include Pundit
  after_action :verify_authorized

  private

  def forbidden_access
    head(:forbidden)
  end

  def current_user
    token = get_token(request.headers[AUTH_HEADER])
    return nil unless token

    User.find_by!(username: token.first["username"])
  end

  def require_jwt
    head(:forbidden) if !valid_token?(request.headers[AUTH_HEADER])
  end

  def valid_token?(token)
    get_token(token).present?
  end

  def get_token(token)
    return false unless token

    token.gsub!(BEARER, "")

    begin
      decoded_token = JWT.decode(
        token,
        Rails.application.credentials.jwt_secret,
        true
      )
    rescue JWT::DecodeError => e
      nil
    end
  end
end
