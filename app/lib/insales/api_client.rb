# frozen_string_literal: true

class Insales::ApiClient
  API_PATH = '/admin'

  attr_reader :login, :password

  def initialize(insales_subdomain, password)
    @insales_subdomain = insales_subdomain
    @password = password
  end

  def get(path = nil)
    response = connection.get(path)
    response.status
  end

  def post(path = nil, body = nil)
    response = connection.post(path, body)
    response.status
  end

  private

  def connection
    @connection ||= Faraday.new(url) do |connection|
      connection.adapter :typhoeus
      connection.request :authorization, :basic, insales_subdomain, password
      connection.request :json
      connection.response :json
    end
  end

  def url
    url_options = { host: insales_subdomain, path: API_PATH }
    AC[:uri_builder].build(url_options)
  end
end
