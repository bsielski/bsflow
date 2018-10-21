require "bsflow/#{File.basename(__FILE__).chomp("_spec.rb")}"
require_relative "../random_values_helper"

RSpec.describe BSFlow::Pipeline do
  subject {
    described_class.new(procs: procs)
  }

  let (:org_input) { random_value }
  let (:input) { Marshal.load(Marshal.dump(org_input)) }
  
  context "no procs" do
    let (:procs) { [] }
    10.times do
      it "returns same value" do
        expect(subject.call(input)).to eq input
      end
    end
  end

  context "one proc" do
    let (:procs) { [double("Fake Proc")] }
    let (:expected_output) { random_value }
    before do
      procs.each do |proc|
        allow(proc)
          .to receive(:call).with(input)
                .and_return(expected_output)
      end
    end
    10.times do
      it "returns correct value" do
        expect(subject.call(input)).to eq expected_output
      end
    end
  end

  context "random number of procs" do
    let (:number_of_procs) { Random.new.rand(2..500) }
    let (:procs) {
      Array.new(number_of_procs) do |i|
        double("Fake Proc Number #{i}")  
      end
    }
    let (:value_timeline) {
      [input] + unique_array(number_of_procs) 
    }
    let (:expected_output) { random_value }
    before do
      procs.each_with_index do |proc, i|
        allow(proc)
          .to receive(:call).with(value_timeline[i])
                .and_return(value_timeline[i + 1])
      end
    end
    10.times do
      it "returns correct value" do
        expect(subject.call(input)).to eq value_timeline.last
      end
    end
  end
end
