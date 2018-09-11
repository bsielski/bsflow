require "c_flow/#{File.basename(__FILE__).chomp("_spec.rb")}"
require_relative "../random_values_helper"

RSpec.describe CFlow::Combine do
  subject (:actual_output) {
    described_class.new(
      sub_procs: sub_procs,
      combine_proc: combine_proc
    ).(input)
  }

  let (:org_input) { random_value }
  let (:input) { Marshal.load(Marshal.dump(org_input)) }
  
  context "no sub_procs" do
    let (:sub_procs) { [] }
    let (:combine_proc) { double("Fake Combine Proc") }

    let (:expected_output) { random_value }
    before do
      allow(combine_proc).
        to receive(:call).
             and_return(expected_output)
    end
    
    10.times do
      it "returns correct value" do
        expect(actual_output).to eq expected_output
      end
    end
  end

  context "one sub_proc" do
    let (:sub_procs) { [double("Fake Sub Proc")] }
    let (:combine_proc) { double("Fake Combine Proc") }
    let (:sub_proc_output) { random_value }
    let (:expected_output) { random_value }
    before do
      sub_procs.each do |sub_proc|
        allow(sub_proc).
          to receive(:call).with(input).
               and_return(sub_proc_output)
      end
    end
    before do
      allow(combine_proc).
        to receive(:call).with(sub_proc_output).
             and_return(expected_output)
    end
    
    10.times do
      it "returns correct value" do
        expect(actual_output).to eq expected_output
      end
    end
  end

  context "random number of sub_procs" do
    let (:number_of_sub_procs) { Random.new.rand(2..100) }
    let (:sub_procs) {
      Array.new(number_of_sub_procs) do |i|
        double("Fake Sub Proc Number #{i}")  
      end
    }
    let (:combine_proc) { double("Fake Combine Proc") }
    let (:sub_proc_outputs) { unique_array(number_of_sub_procs) }
    let (:expected_output) { random_value }
    before do
      sub_procs.each_with_index do |sub_proc, i|
        allow(sub_proc).
          to receive(:call).with(input).
               and_return(sub_proc_outputs[i])
      end
    end
    before do
      allow(combine_proc).
        to receive(:call).with(*sub_proc_outputs).
             and_return(expected_output)
    end
    
    10.times do
      it "returns correct value" do
        expect(actual_output).to eq expected_output
      end
    end
  end

end
