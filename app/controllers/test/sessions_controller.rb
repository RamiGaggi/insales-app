# frozen_string_literal: true

class Test::SessionsController < Test::ApplicationController
  def create
    session_values = params[:session]
    session_values.each do |key, value|
      session[key] = value
    end
    head :created
  end
end
