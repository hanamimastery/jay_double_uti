# frozen_string_literal: true

require "dry/effects"
require "jay_double_uti/decoder"

module JayDoubleUti
  class Authorization
    include Dry::Effects::Handler.Reader(:auth)

    attr_reader :decoder

    def initialize(app)
      @app = app
      @decoder = Decoder.new
    end

    def call(env)
      with_auth(decoder.call(env["HTTP_AUTHORIZATION"])) do
        @app.call(env)
      end
    end
  end
end
