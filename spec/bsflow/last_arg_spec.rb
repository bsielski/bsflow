require "bsflow/#{File.basename(__FILE__).chomp("_spec.rb")}"
require_relative "../random_values_helper"

RSpec.describe BSFlow::LastArg do
  subject {
    described_class.new
  }

  let (:number_of_inputs) { [1, Random.new.rand(2..100)].sample }
  let (:org_inputs) {
    Array.new(number_of_inputs) do |i|
      random_value
    end
  }
  let (:inputs) { Marshal.load(Marshal.dump(org_inputs)) }

  30.times do
    it "returns last input" do
      expect(subject.call(*inputs)).to eq org_inputs.last
    end
  end
end
