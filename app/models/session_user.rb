class SessionUser

  def self.set_api_token(session, api_token)
    session[:api_token] = api_token
  end

  def self.signed_in?(session)
    session[:api_token].present?
  end

  def self.sign_out(session)
    session[:api_token] = nil
  end

end

