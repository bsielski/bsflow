require "c_flow/#{File.basename(__FILE__).chomp("_spec.rb")}"
require_relative "../random_values_helper"

RSpec.describe CFlow::Self do
  subject (:actual_output) {
    described_class.new(
    ).(input)
  }

  let (:org_input) { random_value }
  let (:input) { Marshal.load(Marshal.dump(org_input)) }
  
  10.times do
    it "returns same value" do
      expect(actual_output).to eq input
    end
  end
end
