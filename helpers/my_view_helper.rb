class Hash

  def to_html_attrs
    html_attrs = ""
    a = self.stringify_keys
    self.stringify_keys.each do |key, val|
      html_attrs << "#{key}='#{val}' "
    end
    html_attrs.chop
  end

  def stringify_keys
    r = {}
    self.each{|k, v|
      r[k.to_s] = v
      r
    }
  end
end

module Helpers
  module MyViewHelper

    def tag(name,content,options={})
      with_opts = "<#{name.to_s} #{options.to_html_attrs}>#{content}</#{name}>"
      no_opts = "<#{name.to_s}>#{content}</#{name}>"
      options.empty? ? no_opts : with_opts
    end

    def select_tag(id, name, options, default_value = nil)
      content = ""
      options.each {|o|
        tag_options = {:value => o[0]}
        tag_options[:selected] = "" if o[0] == default_value
        content += tag(:option, o[1], tag_options)
      }
      tag(:select, content, {:id => id, :name => name})
    end
  end
end