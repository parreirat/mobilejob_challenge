module MovieRenter
  class Customer

    NAME_INVALID_MSG = ":name has to be non-empty String."
    RENTAL_INVALID_MSG = ":rental should be a MovieRenter::Rental object."

    attr_reader :name
    attr_reader :rentals

    def initialize(name)
      raise ArgumentError, NAME_INVALID_MSG unless name_valid?(name)
      @name = name
      @rentals ||= []
    end

    def add_rental(rental)
      raise ArgumentError, RENTAL_INVALID_MSG unless rental_valid?(rental)
      @rentals << rental
    end

    def statement

      statement_text = "Rental Record for #{@name}\n"
      total_cost = 0
      frequent_renter_points = 0

      @rentals.each do |rental|
        # Add frequent renter points
        frequent_renter_points += 1
        # Add bonus frequent renter points if any applies
        frequent_renter_points += self.class.bonus_frequent_points(rental)
        # Sum cost of this specific rental onto total statement cost
        total_cost += self.class.rental_cost(rental)
        # Append movie title and cost to our statement
        statement_text += self.class.rental_message(rental)
      end

      # Add footer lines to statement
      statement_text += self.class.statement_footer(total_cost, frequent_renter_points)

    end

    def self.bonus_frequent_points(rental)
      bonus_points = 0
      days_rented = rental.days_rented
      movie = rental.movie
      movie_price_code = movie.price_code
      # Add bonus if it's a new release rental for longer than 1 day
      if movie.is_new? && days_rented > 1
        bonus_points += 1
      end
      # ...other eligible bonuses conditions
      bonus_points
    end

    # Determine cost for this rental according to :price_code of movie
    def self.rental_cost(rental)
      movie = rental.movie
      days_rented = rental.days_rented
      cost = 0
      if movie.is_regular?
        cost += 2
        cost += (days_rented - 2) * 1.5 if days_rented > 2
      elsif  movie.is_new?
        cost += days_rented * 3
      elsif  movie.is_children?
        cost += 1.5
        cost += (days_rented - 3) * 1.5 if days_rented > 3
      end
      cost
    end

    def self.rental_message(rental)
      title = rental.movie.title
      cost = rental_cost(rental)
      "\t#{title}\t#{cost}\n"
    end

    def self.statement_footer(total_cost, frequent_renter_points)
      footer = ""
      footer += "Amount owed is #{total_cost}\n"
      footer += "You earned #{frequent_renter_points} frequent renter points!\n"
      footer
    end

    private

      def name_valid?(title)
        title.is_a?(String) && (not title.empty?)
      end

      def rental_valid?(rental)
        rental.is_a?(MovieRenter::Rental)
      end

  end
end