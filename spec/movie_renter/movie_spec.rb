RSpec.describe MovieRenter::Movie do

  let(:klass)      { MovieRenter::Movie }
  let(:price_code) { klass::PRICE_CODES.values.sample }
  let(:title)      { "title" }

  context "initialization of MovieRenter::Movie" do

    context "success with" do

      it "success with valid price_code/string" do
        expect { klass.new(title, price_code) }.to_not raise_error
      end

    end

    context "exception thrown with" do

      it "invalid price_code - not a value in MovieRenter::Movie::PRICE_CODES" do
        expect { klass.new(title, -1) }.to raise_error(ArgumentError)
      end

      it "invalid price_code - not an Integer" do
        expect { klass.new(title, "string") }.to raise_error(ArgumentError)
      end

      it "invalid title - not a String (nil)" do
        expect { klass.new(nil, price_code) }.to raise_error(ArgumentError)
      end

      it "invalid title - not a String (Integer)" do
        expect { klass.new(0, price_code) }.to raise_error(ArgumentError)
      end

      it "invalid title - empty String" do
        expect { klass.new("", price_code) }.to raise_error(ArgumentError)
      end

    end

  end
end