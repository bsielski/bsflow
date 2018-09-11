require "c_flow/#{File.basename(__FILE__).chomp("_spec.rb")}"
require_relative "../random_values_helper"

RSpec.describe CFlow::UntilTrueLoop do
  subject (:actual_output) {
    described_class.new(
      condition_proc: condition_proc,
      loop_proc: loop_proc
    ).(input)
  }

  let (:org_input) { random_value }
  let (:input) { Marshal.load(Marshal.dump(org_input)) }
  let (:condition_proc) { double("Fake Condition Proc") }
  let (:loop_proc) { double("Fake Loop Proc") }
  
  context "condition is true before any loops" do    
    before do
      allow(condition_proc)
        .to receive(:call).with(input)
              .and_return(true)
    end
    10.times do
      it "returns same value" do
        expect(actual_output).to eq input
      end
    end
  end

  context "condition is true after one loop" do
    let (:first_loop_output) { random_value }
    before do
      allow(loop_proc)
        .to receive(:call).with(input)
              .and_return(first_loop_output)
      allow(condition_proc)
        .to receive(:call).with(input)
              .and_return(false)
      allow(condition_proc)
        .to receive(:call).with(first_loop_output)
              .and_return(true)
    end
    10.times do
      it "returns correct value" do
        expect(actual_output).to eq first_loop_output
      end
    end
  end

  context "condition is true after random number of loops" do
    let (:number_of_loops) { Random.new.rand(2..500) }
    let (:value_timeline) {
      [input] + unique_array(number_of_loops)
    }
    let (:condition_timeline) {
      Array.new(number_of_loops, false) + [true]
    }
    
    before do
      (number_of_loops + 1).times do |i|
        allow(condition_proc)
          .to receive(:call).with(value_timeline[i])
                .and_return(condition_timeline[i])
      end
      number_of_loops.times do |i|      
        allow(loop_proc)
          .to receive(:call).with(value_timeline[i])
                .and_return(value_timeline[i + 1])
      end
    end
    10.times do
      it "returns correct value" do
        expect(actual_output).to eq value_timeline.last
      end
    end
  end
end
