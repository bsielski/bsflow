require "bsflow/#{File.basename(__FILE__).chomp("_spec.rb")}"
require_relative "../random_values_helper"

RSpec.describe BSFlow::Pipeline do
  subject {
    described_class.new(procs: procs)
  }
  let (:org_inputs) { testing_array }
  let (:inputs) { Marshal.load(Marshal.dump(org_inputs)) }
  let (:value_timeline) {
    ([inputs] + [random_value] + testing_array).uniq
  }
  let (:number_of_procs) { value_timeline.length - 1 }
  let (:procs) {
    Array.new(number_of_procs) do |i|
      double("Fake Proc Number #{i}")  
    end
  }
  let (:expected_output) { random_value }
  before do
    procs.each_with_index do |proc, i|
      if i == 0
        if value_timeline[i].empty?
          allow(proc)
            .to receive(:call).with(no_args)
                  .and_return(value_timeline[i + 1])
        else
          allow(proc)
            .to receive(:call).with(*value_timeline[i])
                  .and_return(value_timeline[i + 1])
        end
      else
        allow(proc)
          .to receive(:call).with(value_timeline[i])
                .and_return(value_timeline[i + 1])
      end
    end
  end
  30.times do
    it "returns correct value" do
      expect(subject.call(*inputs)).to eq value_timeline.last
    end
  end
end
