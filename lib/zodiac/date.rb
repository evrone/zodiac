module Zodiac
  module Date

    [:sign, :sign_id, :sign_symbol].each do |symbol|
      method = "zodiac_#{symbol}"
      define_method(method) do                                   # def zodiac_sign
        unless respond_to?(:month) && respond_to?(:day)          #   unless respond_to?(:month) && respond_to?(:day)
          raise "#{self} should respond_to #month and #day"      #     raise "#{self} should respond_to #month and #day"
        end                                                      #   end
        Finder.public_send(                                      #   Finder.public_send(
          "#{symbol}_for", { month: self.month, day: self.day }  #     'sign_for', { month: self.month, day: self.day }
        )                                                        #   )
      end                                                        # end
    end

    Zodiac.each_sign do |symbol, integer|
      define_method("#{symbol}?") do                             # def libra?
        self.zodiac_sign_id == integer                           #   self.zodiac_sign_id == 7
      end                                                        # end
    end

  end
end

[Time, Date, DateTime].each do |klass|
  klass.send(:include, Zodiac::Date)
end
