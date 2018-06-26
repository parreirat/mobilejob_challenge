module MovieRenter
  class Movie
    CHILDRENS_MOVIE = 2
    REGULAR = 0
    NEW_RELEASE = 1

    attr_reader :title_for_movie
    attr_accessor :price_code

    def initialize(title_for_movie, price_code)
      @title_for_movie, @price_code = title_for_movie, price_code
    end
  end
end