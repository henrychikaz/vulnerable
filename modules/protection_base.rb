Dir[File.join("#{File.dirname(__FILE__)}", "**", "*.rb")].each do |f|
  require f
end

module ProtectionBase
  def self.included(klass)

  end
  def implement_protection_strategy_in_request(instance)
    implement_xss_response_protection_strategy_in_request(instance)
  end

  def implement_protection_strategy_in_response(instance)
    implement_xss_response_protection_strategy_in_response instance
  end

  def encode_output(record)
    encode_output_for_xss(record)
  end

  def implement_xss_response_protection_strategy_in_request(instance)
    classify(session[:xss_settings], "XSS").implement_protection_strategy_in_request(instance)
  end

  def implement_xss_response_protection_strategy_in_response(instance)
    classify(session[:xss_settings], "XSS").implement_protection_strategy_in_response instance
  end

  def encode_output_for_xss(record)
    classify(session[:xss_settings], "XSS").encode_output record
  end

  def classify(name, namespace = "")
    object_name = "#{namespace}::#{name.split("_").collect{|x| x.capitalize}.join}"
    Object::const_get(object_name)
  end
end