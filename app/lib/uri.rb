# frozen_string_literal: true

module Uri
  class Builder
    def self.build(*args)
      URI::HTTPS.build(*args)
    end
  end

  class BuilderStub
    def self.build(*args)
      URI::HTTP.build(*args)
    end
  end
end
