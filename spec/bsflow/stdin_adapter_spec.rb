require "bsflow/#{File.basename(__FILE__).chomp("_spec.rb")}"
require_relative "../random_values_helper"

RSpec.describe BSFlow::StdinAdapter do
  subject {
    described_class.new(stdin: stdin)
  }
  let (:stdin) { double "StdIn" }

  scenarios = [
    { stdin: " 43rfc3r \n", adapter_output: " 43rfc3r " },
    { stdin: "\n", adapter_output: "" },
    { stdin: "23d r 3 2r 23r\n", adapter_output: "23d r 3 2r 23r" },
    { stdin: "gerga2\n", adapter_output: "gerga2" }
  ]

  scenarios.each do |scenario|
    context "stdin: #{scenario[:stdin].inspect}" do
      before do
        allow(stdin).to receive(:gets).and_return(scenario[:stdin])
      end
      
      it "returns #{scenario[:adapter_output].inspect}" do
        expect(subject.call).to eq scenario[:adapter_output]
      end
    end
  end
end
