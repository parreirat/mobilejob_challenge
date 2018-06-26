RSpec.describe MovieRenter::Rental do

  let(:klass)       { MovieRenter::Rental }
  let(:movie)       { MovieRenter::Movie.new("title", 0) }
  let(:days_rented) { Random.rand(1..10) }

  context "initialization of MovieRenter::Rental" do

    context "success with" do

      it "valid movie/days_rented" do
        expect { klass.new(movie, days_rented) }.to_not raise_error
      end

    end

    context "exceptions thrown with" do

      it "invalid movie - not a MovieRenter::Movie" do
        expect { klass.new("string", days_rented) }.to raise_error(ArgumentError)
      end

      it "invalid days_rented - not an Integer" do
        expect { klass.new(movie, "string") }.to raise_error(ArgumentError)
      end

    end

  end

end
