module XSS
  module Csp
    def self.implement_protection_strategy_in_response(response)
      pp response
      response.headers["Content-Security-Policy"] = "default-src 'self' http://www.w3schools.com;"
    end
  end
end