module Gemmmmy
  class Prettifier
    def initialize(screen_name=nil)
      @screen_name = screen_name
    end

    def prettify!(response)
      puts parse(response)
    end

    def parse(object)
      type = type_of(object)
      if type
        return send("parse_#{type}", object)
      else
        return object
      end
    end

    def parse_tweet(tweet)
      name_text = "#{tweet[:user][:name]}(#{tweet[:user][:screen_name]})"
      return "#{color_name(name_text, tweet[:user][:screen_name])}: #{color_text(tweet[:text])}"
    end

    def parse_direct_message(dm)
      name_text = "#{dm[:sender][:name]}(#{dm[:sender][:screen_name]})"
      return "#{color_name(name_text, dm[:sender][:screen_name])}: #{color_text dm[:text]}"
    end

    def parse_list(list)
      name_text = "#{list[:user][:name]}(#{list[:user][:screen_name]})"
      return "#{color_name(name_text, list[:user][:screen_name])}: #{list[:name]} - \e[90m#{list[:description]}\e[m"
    end

    def parse_user(user)
      puts user
      at_name = "@#{user[:screen_name]}"
      description = "#{color_name(at_name, user[:screen_name])} - #{user[:name]}"
      return [description, user.attrs.to_yaml]
    end

    def parse_trend(trend)
      return "#{trend[:name]} - \e[90m#{trend[:url]}\e[m"
    end

    def parse_array(array)
      return array.map{|obj| parse(obj)}.reverse
    end

    def parse_cursor(cursor)
      return parse_array(cursor.collection)
    end

    def type_of(object)
      if object.respond_to? :map
        return :array
      elsif object.class.to_s.start_with? "Twitter::"
        class_name = object.class.to_s
        return class_name.slice(9, class_name.length).underscore.to_sym
      end
    end

    def color_text(text)
      return text.gsub(/@([a-zA-Z0-9_]+)/) do
        "\e[#{color_of($1)}m@#{$1}\e[m"
      end
    end

    def color_name(name_text, screen_name)
      return "\e[#{color_of(screen_name)}m#{name_text}\e[m"
    end

    # copied https://github.com/jugyo/earthquake
    def color_of(screen_name)
      colors = (31..36).to_a
      color = colors[screen_name.delete("^0-9A-Za-z_").to_i(36) % colors.size]
      color += 10 if @screen_name == screen_name
      return color
    end
  end
end
