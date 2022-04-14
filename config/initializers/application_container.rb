# frozen_string_literal: true

class ApplicationContainer
  extend Dry::Container::Mixin

  if Rails.env.production?
    register :uri_builder, -> { Uri::Builder }
    register :monitoring, -> { Monitoring::Service }
  else
    register :uri_builder, -> { Uri::BuilderStub }
    register :monitoring, -> { Monitoring::ServiceStub }
  end
end
AC = ApplicationContainer
