module XSS
  module DisallowHtmlTag

    def self.implement_protection_strategy_in_request(instance)
      instance.instance_eval do
        if params.keys.any?{|x| params[x].index("<") or params[x].index(">") }
          flash.next[:error] = "Input contains invalid characters!"
          redirect to("/")
        end
      end
    end

    def self.implement_protection_strategy_in_response(instance)
    end

    def self.encode_output(record)
      record
    end

  end
end