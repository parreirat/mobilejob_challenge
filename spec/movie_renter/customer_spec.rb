RSpec.describe MovieRenter::Customer do

  let(:klass)    { MovieRenter::Customer }
  let(:movie)    { MovieRenter::Movie.new("title", 0) }
  let(:rental)   { MovieRenter::Rental.new(movie, 1) }
  let(:customer) { klass.new("tiago") }

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

  context "#bonus_frequent_points" do
  end

  context "#rental_cost" do
  end

  context "#rental_message" do
  end

  context "#statement_footer" do
  end

end