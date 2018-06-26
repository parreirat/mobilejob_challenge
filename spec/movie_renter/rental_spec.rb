RSpec.describe MovieRenter::Rental do

  let(:movie)       { MovieRenter::Movie.new() }
  let(:days_rented) { Random.rand(1..10) }

  context "initialization of MovieRenter::Rental" do

    it "success with valid movie/days_rented" do
      expect { MovieRenter::Rental.new(movie, days_rented)}.to_not raise_error
    end

    it "exception thrown with invalid movie" do
      expect { MovieRenter::Rental.new("string", days_rented)}.to raise_error
    end

    it "exception thrown with invalid days_rented" do
      expect { MovieRenter::Rental.new(movie, "string")}.to raise_error
    end

  end


end
