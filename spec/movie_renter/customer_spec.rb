RSpec.describe MovieRenter::Customer do

  let(:klass)        { MovieRenter::Customer }
  let(:movie_klass)  { MovieRenter::Movie }
  let(:rental_klass) { MovieRenter::Rental }
  let(:movie)        { MovieRenter::Movie.new("title", 0) }
  let(:rental)       { MovieRenter::Rental.new(movie, 1) }
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

    end

    context "exception thrown with" do

      it "invalid rental" do
        expect { customer.add_rental("string") }.to raise_error(ArgumentError)
      end

    end

  end

  context "#statement" do
  end

  context ".bonus_frequent_points" do

    context "regular movies" do
      let(:movie) { movie_klass.new("title", movie_klass::PRICE_CODES[:REGULAR]) }
      it "with 1 day rental" do
        rental = rental_klass.new(movie, 1)
        expect(klass.bonus_frequent_points(rental)).to eq(0)
      end
    end

    context "regular movies" do
      let(:movie) { movie_klass.new("title", movie_klass::PRICE_CODES[:NEW]) }

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
      let(:movie) { movie_klass.new("title", movie_klass::PRICE_CODES[:CHILDREN]) }
      it "with 1 day rental" do
        rental = rental_klass.new(movie, 1)
        expect(klass.bonus_frequent_points(rental)).to eq(0)
      end
    end

  end

  context ".rental_cost" do

    context "regular movies" do
      let(:movie) { movie_klass.new("title", movie_klass::PRICE_CODES[:REGULAR]) }

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
      let(:movie) { movie_klass.new("title", movie_klass::PRICE_CODES[:NEW]) }

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
      let(:movie) { movie_klass.new("title", movie_klass::PRICE_CODES[:CHILDREN]) }

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

  # context ".rental_message" do
  # end

  # context ".statement_footer" do
  # end

end