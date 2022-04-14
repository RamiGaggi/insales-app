# frozen_string_literal: true

class Uri::Builder
  def self.build(*args)
    URI::HTTPS.build(*args)
  end
end
