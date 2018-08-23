module Messenger
  module Bot
    module Config
      class << self
        attr_accessor :access_token

        attr_accessor :secret_token

        attr_accessor :validation_token
        
        attr_accessor :math_access_token
      end
    end
  end
end
