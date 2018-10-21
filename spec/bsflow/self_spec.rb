require "bsflow/#{File.basename(__FILE__).chomp("_spec.rb")}"
require_relative "../random_values_helper"

RSpec.describe BSFlow::Self do
  subject {
    described_class.new
  }

  let (:org_input) { random_value }
  let (:input) { Marshal.load(Marshal.dump(org_input)) }
  
  10.times do
    it "returns same value" do
      expect(subject.call(input)).to eq input
    end
  end
end
