# frozen_string_literal: true

class Web::SessionsController < Web::ApplicationController
  def new; end

  def create
    account = Account.find_by(insales_subdomain: params[:insales_subdomain])
    if account
      redirect_to_insales_login_page account
    else
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to new_session_path
  end
end
