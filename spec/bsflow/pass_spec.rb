require "bsflow/#{File.basename(__FILE__).chomp("_spec.rb")}"
require_relative "../random_values_helper"

RSpec.describe BSFlow::Pass do
  subject {
    described_class.new(proc: proc)
  }

  let (:org_input) { random_value }
  let (:input) { Marshal.load(Marshal.dump(org_input)) }

  context "proc exists" do
    let (:proc) { double("Fake Proc") }
    let (:expected_output) { random_value }

    before do
      allow(proc)
        .to receive(:call).with(org_input)
              .and_return(expected_output)
    end

    10.times do
      it "returns correct value" do
        expect(subject.call(input)).to eq org_input
      end
    end
  end
end
