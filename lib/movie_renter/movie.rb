module MovieRenter
  class Movie

    PRICE_CODES = { REGULAR: 0, NEW: 1, CHILDREN: 2 }
    PRICE_CODES.each do |method, value|
      method = method.to_s.downcase
      # returns true/false for is_regular?, is_new?, is_children?, etc.
      self.define_method("is_#{method}?".to_sym) do
        return self.price_code == PRICE_CODES[method.upcase.to_sym]
      end
    end

    TITLE_INVALID_MSG =
      <<~HEREDOC.delete("\n")
        Price code is invalid, can only be one of the
         following values: #{PRICE_CODES.values}
      HEREDOC
    PRICE_CODE_INVALID_MSG = "Movie title cannot be empty."

    attr_reader :price_code
    attr_reader :title

    def initialize(title, price_code)
      raise ArgumentError, TITLE_INVALID_MSG unless price_code_valid?(price_code)
      raise ArgumentError, PRICE_CODE_INVALID_MSG unless title_valid?(title)
      @title      = title
      @price_code = price_code
    end

    private

      def title_valid?(title)
        title.is_a?(String) && (not title.empty?)
      end

      def price_code_valid?(price_code)
        price_code.is_a?(Integer) &&
        PRICE_CODES.values.include?(price_code)
      end

  end
end