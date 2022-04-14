# frozen_string_literal: true

class Web::ApplicationController < ActionController::Base
  include Web::AuthConcern
end
