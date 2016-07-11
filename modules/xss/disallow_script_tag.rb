module XSS
  module DisallowScriptTag

    def self.implement_protection_strategy_in_request(instance)
      instance.instance_eval do
        if params["name"].downcase.index("<script>") or params["feedback"].downcase.index("<script>")
          flash.next[:error] = "Input contains invalid characters!"
          redirect to("/#Feedback")
        end
      end
    end

    def self.implement_protection_strategy_in_response(instance)
    end

  end
end