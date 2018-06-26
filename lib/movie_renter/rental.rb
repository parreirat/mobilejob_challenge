module MovieRenter
  class Rental

    attr_reader :movie
    attr_reader :days_rented

    MOVIE_INVALID_MSG = ":movie should be a MovieRenter::Movie object"
    DAYS_RENTED_INVALID_MSG = ":days_rented is not a valid integer"

    def initialize(movie, days_rented)
      raise ArgumentError, MOVIE_INVALID_MSG unless movie_valid?(movie)
      raise ArgumentError, DAYS_RENTED_INVALID_MSG unless days_rented_valid?(days_rented)
      @movie       = movie
      @days_rented = days_rented
    end

    private

      def movie_valid?(movie)
        movie.is_a?(MovieRenter::Movie)
      end

      def days_rented_valid?(days_rented)
        days_rented.is_a?(Integer)
      end

  end
end