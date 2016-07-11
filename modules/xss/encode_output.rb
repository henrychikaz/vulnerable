module XSS
  module EncodeOutput
    def self.implement_protection_strategy_in_response(instance)
    end

    def self.encode_output(record)
      rec = {}
      record.each{|k,v|
        if(v.is_a? String)
          rec[k] = CGI.escapeHTML(v)
        else
          rec[k] = v
        end
      }
      rec
    end
  end
end