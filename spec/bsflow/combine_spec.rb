require "bsflow/#{File.basename(__FILE__).chomp("_spec.rb")}"
require_relative "../random_values_helper"

RSpec.describe BSFlow::Combine do
  subject {
    described_class.new(
      sub_procs: sub_procs,
      combine_proc: combine_proc
    )
  }

  let (:combine_proc) { double("Fake Combine Proc") }
  let (:number_of_sub_procs) { [0, 1, Random.new.rand(2..100)].sample }
  let (:sub_procs) {
    Array.new(number_of_sub_procs) do |i|
      double("Fake Sub Proc Number #{i}")  
    end
  }
  let (:number_of_inputs) { [0, 1, Random.new.rand(2..100)].sample }
  let (:org_inputs) {
    Array.new(number_of_inputs) do |i|
      random_value
    end
  }
  let (:inputs) { Marshal.load(Marshal.dump(org_inputs)) }
  let (:sub_proc_outputs) { unique_array(number_of_sub_procs) }
  let (:expected_output) { random_value }

  before do
    sub_procs.each_with_index do |sub_proc, i|
      unless number_of_inputs == 0
        allow(sub_proc).
          to receive(:call).with(*inputs).
               and_return(sub_proc_outputs[i])
      else
        allow(sub_proc).
          to receive(:call).
               and_return(sub_proc_outputs[i])
      end
    end
  end
  before do
    unless sub_proc_outputs.empty?
      allow(combine_proc).
        to receive(:call).with(*sub_proc_outputs).
             and_return(expected_output)
    else
      allow(combine_proc).
        to receive(:call).
             and_return(expected_output)
    end
  end
  
  30.times do
    it "returns correct value" do
      expect(subject.call(*inputs)).to eq expected_output
    end
  end
end
