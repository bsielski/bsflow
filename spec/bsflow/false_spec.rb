require "bsflow/#{File.basename(__FILE__).chomp("_spec.rb")}"
require_relative "../random_values_helper"

RSpec.describe BSFlow::False do
  subject {
    described_class.new
  }

  let (:org_input) { random_value }
  let (:input) { Marshal.load(Marshal.dump(org_input)) }
  
  10.times do
    it "returns false" do
      expect(subject.call(input)).to be false
    end
  end
end
