class JwtService
  HMAC = Rails.application.secret_key_base

  class << self
    # Encode the token
    def encode(payload)
      JWT.encode(payload, HMAC, 'HS256')
    end

    # Decode the token
    def decode(token)
      body = JWT.decode(token, HMAC, true, algorithm: 'HS256')[0]
      HashWithIndifferentAccess.new(body)

    # If Expired get nil
    rescue JWT::ExpiredSignature
      nil
    end
  end
end
