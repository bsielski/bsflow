require "bsflow/#{File.basename(__FILE__).chomp("_spec.rb")}"
require_relative "../random_values_helper"

RSpec.describe BSFlow::Combine do
  let (:org_inputs) { testing_array }
  let (:number_of_inputs) { org_inputs.length }
  let (:inputs) { Marshal.load(Marshal.dump(org_inputs)) }

  let (:sub_proc_outputs) { testing_array }

  let (:number_of_sub_procs) { sub_proc_outputs.length }
  let (:all_sub_procs) {
    Array.new(number_of_sub_procs) do |i|
      double("Fake Sub Proc Number #{i}")  
    end
  }
  let (:expected_output) { random_value }
  let (:combine_proc) { double("Fake Combine Proc") }

  before do
    all_sub_procs.each_with_index do |sub_proc, i|
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
    subject {
      described_class.new(
        sub_procs: all_sub_procs,
        combine_proc: combine_proc
      )
    }
    it "returns correct value" do
      expect(subject.call(*inputs)).to eq expected_output
    end
  end

  context "procs passed only like normal arguments" do
    subject {
      described_class.new(
        *all_sub_procs,
        combine_proc: combine_proc
      )
    }
    30.times do
      it "returns correct value" do
        expect(subject.call(*inputs)).to eq expected_output
      end
    end

  end
  context "procs passed only by array with keyword" do
    subject {
      described_class.new(
        sub_procs: all_sub_procs,
        combine_proc: combine_proc
      )
    }
    30.times do
      it "returns correct value" do
        expect(subject.call(*inputs)).to eq expected_output
      end
    end
  end

  context "procs passed both ways simultanously" do
    let (:split_point) { Random.new.rand(0..(number_of_sub_procs)) }
    let (:arg_procs) { all_sub_procs[0, split_point] }
    let (:kw_procs)  { all_sub_procs[split_point..-1] }
    
    subject {
      described_class.new(
        *arg_procs,
        sub_procs: kw_procs,
        combine_proc: combine_proc
      )
    }
    30.times do
      it "returns correct value" do
        expect(subject.call(*inputs)).to eq expected_output
      end
    end
  end

end
