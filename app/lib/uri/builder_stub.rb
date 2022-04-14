# frozen_string_literal: true

class Uri::BuilderStub
  def self.build(*args)
    URI::HTTP.build(*args)
  end
end
