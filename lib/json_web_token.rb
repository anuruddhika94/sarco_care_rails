class JsonWebToken
  ALGORITHM = "HS256"

  class << self
    def encode(payload, exp: 30.days.from_now)
      payload = payload.dup
      payload[:exp] = exp.to_i
      JWT.encode(payload, secret, ALGORITHM)
    end

    # Returns the decoded payload (HashWithIndifferentAccess), or nil if the
    # token is missing, malformed, expired, or signed with a different secret.
    def decode(token)
      body = JWT.decode(token, secret, true, algorithm: ALGORITHM).first
      ActiveSupport::HashWithIndifferentAccess.new(body)
    rescue JWT::DecodeError
      nil
    end

    private

    def secret
      Rails.application.secret_key_base
    end
  end
end
