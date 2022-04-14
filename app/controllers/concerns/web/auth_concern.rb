# frozen_string_literal: true

module Web::AuthConcern
  def sign_in(account_id)
    reset_session
    session[:account_id] = account_id
  end

  def sign_out
    reset_session
  end

  def signed_in?
    !!current_account
  end

  def current_account
    @current_account ||= Account.find_by(id: session[:account_id])
  end

  def authenticate_account
    return if signed_in?
    redirect_to new_session_path
  end

  def redirect_to_insales_login_page(account)
    session[:login_account_id] = account.id

    token = SecureRandom.hex
    account_token = Insales::AppAuth.sign_with_password(token, account.insales_application_password)
    session[:account_token] = account_token

    insales_auth_url = Insales::AppAuth.generate_insales_auth_url(account.insales_subdomain, token, callback_url)
    redirect_to insales_auth_url, allow_other_host: true
  end
end
