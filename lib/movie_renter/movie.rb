module MovieRenter
  class Movie

    PRICE_CODES = { regular: 0, new: 1, children: 2 }

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