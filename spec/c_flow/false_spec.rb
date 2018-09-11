require "c_flow/#{File.basename(__FILE__).chomp("_spec.rb")}"
require_relative "../random_values_helper"

RSpec.describe CFlow::False do
  subject (:actual_output) {
    described_class.new(
    ).(input)
  }

  let (:org_input) { random_value }
  let (:input) { Marshal.load(Marshal.dump(org_input)) }
  
  10.times do
    it "returns false" do
      expect(actual_output).to be false
    end
  end
end
