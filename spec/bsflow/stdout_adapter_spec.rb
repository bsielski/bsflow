require "bsflow/#{File.basename(__FILE__).chomp("_spec.rb")}"
require_relative "../random_values_helper"

RSpec.describe BSFlow::StdoutAdapter do
  subject {
    described_class.new(stdout: stdout)
  }
  let (:stdout) { double "StdOut" }

  scenarios = [
    { stdout: " 43rfc3r \n" },
    { stdout: "\n" },
    { stdout: "23d r 3 2r 23r\n" },
    { stdout: "gerga2\n" }
  ]

  scenarios.each do |scenario|
    it "passes string to stream" do
      expect(stdout).to receive(:puts).with(scenario[:stdout]).and_return(nil)
      subject.call(scenario[:stdout])
    end
  end
end
