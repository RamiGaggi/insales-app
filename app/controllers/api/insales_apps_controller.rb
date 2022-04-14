# frozen_string_literal: true

class Api::InsalesAppsController < Api::ApplicationController
  def install
    if Insales::App.install(insales_app_params)
      head :ok
    else
      AC[:monitoring].error('InSales application install failure', insales_id: insales_app_params[:insales_id])
      head :unprocessable_entity
    end
  end

  def uninstall
    if Insales::App.uninstall(insales_app_params)
      head :ok
    else
      AC[:monitoring].error('InSales application uninstall failure', insales_id: insales_app_params[:insales_id])
      head :unprocessable_entity
    end
  end

  private

  def insales_app_params
    params.permit(:insales_id, :shop, :token)
  end
end
