module XSS
  module NoProtection
    def self.implement_protection_strategy_in_request(instance)
    end

    def self.implement_protection_strategy_in_response(instance)
    end

    def self.encode_output(record)
      record
    end
  end
end