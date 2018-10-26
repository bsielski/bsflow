require "bsflow/#{File.basename(__FILE__).chomp("_spec.rb")}"
require_relative "../random_values_helper"

RSpec.describe BSFlow::SquareBracketsAdapter do
  subject(:get_operation) {
    described_class.new(map: map)
  }
  let (:map) { double "Map" }
  let (:key) { Random.new.rand }
  let (:value) { Random.new.rand }

  10.times do
    before do
      allow(map).to receive(:[]).with(key).and_return(value)
    end
    
    it "returns proper value" do
      expect(get_operation.call(key)).to eq value
    end
  end
end
