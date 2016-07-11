Dir[File.join(".", "**/*.rb")].each do |f|
  require f
end
module ProtectionBase
  def implement_protection_strategy_in_response(response)
    implement_xss_response_protection_strategy response
  end

  def implement_xss_response_protection_strategy(response)
    classify(session[:xss_settings], "XSS").implement_protection_strategy_in_response response
  end

  def classify(name, namespace = "")
    object_name = "#{namespace}::#{name.split("_").collect{|x| x.capitalize}.join}"
    Object::const_get(object_name)
  end
end