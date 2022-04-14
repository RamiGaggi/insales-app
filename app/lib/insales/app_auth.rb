# frozen_string_literal: true

module Insales::AppAuth
  def self.generate_insales_auth_url(account_subdomain, token, callback)
    host = account_subdomain
    path = "/admin/applications/#{Rails.application.credentials.insales[:app_api_key]}/login"
    query = "token=#{token}&login=#{callback}"
    AC[:uri_builder].build(host:, path:, query:).to_s
  end

  def self.sign_with_password(nonce, password)
    Digest::MD5.hexdigest("#{nonce}#{password}")
  end

  def self.sign_with_app_secret(nonce)
    app_secret = Rails.application.credentials.insales[:app_secret]
    Digest::MD5.hexdigest("#{nonce}#{app_secret}")
  end

  def self.params_verified_by_session?(params, session)
    params[:token] == session[:account_token]
  end

  def self.password_verified_by_account?(password, account)
    password == account.insales_application_password
  end
end
