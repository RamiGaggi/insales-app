# frozen_string_literal: true

class Web::AuthController < Web::ApplicationController
  def callback
    if Insales::AppAuth.params_verified_by_session?(params, session)
      sign_in session[:login_account_id]
      redirect_to root_path
    else
      redirect_to new_session_path
    end
  end

  def login
    account = Account.find_by(insales_id: params[:insales_id])
    if account
      redirect_to_insales_login_page account
    else
      redirect_to new_session_path
    end
  end
end
