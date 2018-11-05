require "bsflow/#{File.basename(__FILE__).chomp("_spec.rb")}"
require_relative "../random_values_helper"

RSpec.describe BSFlow::Pipeline do
  let (:org_inputs) { testing_array }
  let (:inputs) { Marshal.load(Marshal.dump(org_inputs)) }
  let (:value_timeline) {
    ([inputs] + [random_value] + testing_array).uniq
  }
  let (:number_of_procs) { value_timeline.length - 1 }
  let (:all_procs) {
    Array.new(number_of_procs) do |i|
      double("Fake Proc Number #{i}")  
    end
  }
  let (:expected_output) { random_value }
  before do
    all_procs.each_with_index do |proc, i|
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
  context "procs passed only like normal arguments" do
    subject {
      described_class.new(*all_procs)
    }
    30.times do
      it "returns correct value" do
        expect(subject.call(*inputs)).to eq value_timeline.last
      end
    end

  end
  context "procs passed only by array with keyword" do
    subject {
      described_class.new(procs: all_procs)
    }
    30.times do
      it "returns correct value" do
        expect(subject.call(*inputs)).to eq value_timeline.last
      end
    end
  end

  context "procs passed both ways simultanously" do
    let (:split_point) { Random.new.rand(0..(number_of_procs)) }
    let (:arg_procs) { all_procs[0, split_point] }
    let (:kw_procs)  { all_procs[split_point..-1] }
    
    subject {
      described_class.new(*arg_procs, procs: kw_procs)
    }
    30.times do
      it "returns correct value" do
        expect(subject.call(*inputs)).to eq value_timeline.last
      end
    end
  end

end
