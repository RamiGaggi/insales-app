# frozen_string_literal: true

module Insales::App
  def self.install(application_params)
    insales_id = application_params[:insales_id]
    insales_subdomain = application_params[:shop]
    insales_application_password = Insales::AppAuth.sign_with_app_secret(application_params[:token])
    account = Account.new(insales_id:, insales_subdomain:, insales_application_password:)
    account.save
  end

  def self.uninstall(application_params)
    insales_id = application_params[:insales_id]
    insales_subdomain = application_params[:shop]
    account = Account.find_by(insales_id:, insales_subdomain:)
    return unless account

    insales_application_password = Insales::AppAuth.sign_with_app_secret(application_params[:token])
    return unless Insales::AppAuth.password_verified_by_account?(insales_application_password, account)

    account.destroy
  end
end
