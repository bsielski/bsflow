require "bsflow/#{File.basename(__FILE__).chomp("_spec.rb")}"
require_relative "../random_values_helper"

def generate_args
  number_of_inputs = [0, 1, Random.new.rand(2..100)].sample
  Array.new(number_of_inputs) do |i|
    random_value
  end
end

RSpec.describe BSFlow::Pipeline do
  subject {
    described_class.new(procs: procs)
  }
  let (:org_inputs) { generate_args }
  let (:inputs) { Marshal.load(Marshal.dump(org_inputs)) }
  let (:number_of_procs) { [1, Random.new.rand(2..100)].sample }
  let (:procs) {
    Array.new(number_of_procs) do |i|
      double("Fake Proc Number #{i}")  
    end
  }
  let (:value_timeline) {
    [inputs] + unique_array(number_of_procs)
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
