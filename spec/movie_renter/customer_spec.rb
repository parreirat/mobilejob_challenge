RSpec.describe MovieRenter::Customer do

  let(:klass)        { MovieRenter::Customer }
  let(:movie_klass)  { MovieRenter::Movie }
  let(:rental_klass) { MovieRenter::Rental }
  let(:movie)        { MovieRenter::Movie.new("title", 0) }
  let(:rental)       { MovieRenter::Rental.new(movie, 1) }
  let(:price_codes)  { MovieRenter::Movie::PRICE_CODES }
  let(:customer)     { klass.new("tiago") }

  context ".new" do

    context "success with" do

      it "valid name" do
        expect { klass.new("tiago") }.to_not raise_error
      end

    end

    context "exception thrown with" do

      it "invalid name - nil" do
        expect { klass.new(nil) }.to raise_error(ArgumentError)
      end

      it "invalid name - empty string" do
        expect { klass.new("") }.to raise_error(ArgumentError)
      end

    end

  end

  context "#add_rental" do

    context "success with" do

      it "valid rental" do
        expect { customer.add_rental(rental) }.to_not raise_error
      end

      let(:rental1) { MovieRenter::Rental.new(movie, 1) }
      let(:movie2)  { MovieRenter::Movie.new("blabla", 2) }
      let(:rental2) { MovieRenter::Rental.new(movie2, 1) }
      it "adding of valid rental" do
        expect(customer.rentals).to eq []
        customer.add_rental(rental1)
        expect(customer.rentals).to eq [rental1]
        customer.add_rental(rental2)
        expect(customer.rentals).to eq [rental1, rental2]
      end

    end

    context "exception thrown with" do

      it "invalid rental" do
        expect { customer.add_rental("string") }.to raise_error(ArgumentError)
      end

    end

  end

  context ".bonus_frequent_points" do

    context "regular movies" do
      let(:movie) { movie_klass.new("title", price_codes[:REGULAR]) }
      it "with 1 day rental" do
        rental = rental_klass.new(movie, 1)
        expect(klass.bonus_frequent_points(rental)).to eq(0)
      end
    end

    context "regular movies" do
      let(:movie) { movie_klass.new("title", price_codes[:NEW]) }

      it "with 1 day rental" do
        rental = rental_klass.new(movie, 1)
        expect(klass.bonus_frequent_points(rental)).to eq(0)
      end

      it "with > 1 day rental" do
        rental = rental_klass.new(movie, Random.rand(2..10))
        expect(klass.bonus_frequent_points(rental)).to eq(1)
      end

    end

    context "children movies" do
      let(:movie) { movie_klass.new("title", price_codes[:CHILDREN]) }
      it "with 1 day rental" do
        rental = rental_klass.new(movie, 1)
        expect(klass.bonus_frequent_points(rental)).to eq(0)
      end
    end

  end

  context ".rental_cost" do

    context "regular movies" do
      let(:movie) { movie_klass.new("title", price_codes[:REGULAR]) }

      it "with 1 day rental" do
        rental = rental_klass.new(movie, 1)
        expect(klass.rental_cost(rental)).to eq(2)
      end

      it "with 5 day rental" do
        rental = rental_klass.new(movie, 5)
        expect(klass.rental_cost(rental)).to eq(6.5)
      end

    end

    context "new movies" do
      let(:movie) { movie_klass.new("title", price_codes[:NEW]) }

      it "with 1 day rental" do
        rental = rental_klass.new(movie, 1)
        expect(klass.rental_cost(rental)).to eq(3)
      end

      it "with 5 day rental" do
        rental = rental_klass.new(movie, 5)
        expect(klass.rental_cost(rental)).to eq(15)
      end

    end

    context "children movies" do
      let(:movie) { movie_klass.new("title", price_codes[:CHILDREN]) }

      it "with 1 day rental" do
        rental = rental_klass.new(movie, 1)
        expect(klass.rental_cost(rental)).to eq(1.5)
      end

      it "with 5 day rental" do
        rental = rental_klass.new(movie, 5)
        expect(klass.rental_cost(rental)).to eq(4.5)
      end

    end

  end

  context "#statement" do

    it "expect this statement with 8 movies to have the following statement" do
      rentals = []
      movie1  = MovieRenter::Movie.new("My Little Pony 1"  , price_codes[:CHILDREN])
      movie2  = MovieRenter::Movie.new("My Little Pony 2"  , price_codes[:CHILDREN])
      movie3  = MovieRenter::Movie.new("Gone With the Wind", price_codes[:REGULAR])
      movie4  = MovieRenter::Movie.new("Star Wars 1"       , price_codes[:REGULAR])
      movie5  = MovieRenter::Movie.new("Star Wars 2"       , price_codes[:REGULAR])
      movie6  = MovieRenter::Movie.new("Jaws"              , price_codes[:NEW])
      movie7  = MovieRenter::Movie.new("Doctor Zhivago"    , price_codes[:NEW])
      movie8  = MovieRenter::Movie.new("E.T"               , price_codes[:NEW])
      rentals << MovieRenter::Rental.new(movie1, 1)
      rentals << MovieRenter::Rental.new(movie2, 4)
      rentals << MovieRenter::Rental.new(movie3, 1)
      rentals << MovieRenter::Rental.new(movie4, 4)
      rentals << MovieRenter::Rental.new(movie5, 1)
      rentals << MovieRenter::Rental.new(movie6, 4)
      rentals << MovieRenter::Rental.new(movie7, 1)
      rentals << MovieRenter::Rental.new(movie8, 4)
      rentals.each { |rental| customer.add_rental(rental)}
      expected_statement = "Rental Record for tiago\n\tMy Little Pony 1\t"
      expected_statement += "1.5\n\tMy Little Pony 2\t3.0\n\tGone With the"
      expected_statement += " Wind\t2\n\tStar Wars 1\t5.0\n\tStar Wars 2\t"
      expected_statement += "2\n\tJaws\t12\n\tDoctor Zhivago\t3\n\tE.T\t12"
      expected_statement += "\nAmount owed is 40.5\nYou earned 10 frequent"
      expected_statement += " renter points!\n"
      expect(customer.statement).to eq(expected_statement)
    end

  end

  # context ".rental_message" do
  # end

  # context ".statement_footer" do
  # end

end