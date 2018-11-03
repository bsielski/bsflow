require "bsflow/#{File.basename(__FILE__).chomp("_spec.rb")}"
require_relative "../random_values_helper"

RSpec.describe BSFlow::DropArgs do
  subject {
    described_class.new(proc: proc)
  }
  let (:proc)   { double("Fake Proc") }
  let (:args)   { testing_array }
  let (:output) { random_value }

  10.times do
    before do
      allow(proc).to receive(:call).with(no_args).and_return(output)
    end

    it "returns proper value" do
      expect(subject.call(*args)).to eq output
    end
  end
end
