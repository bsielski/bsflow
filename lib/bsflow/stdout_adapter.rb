module BSFlow
  class StdoutAdapter
    def initialize(stdout:)
      @stdout = stdout
    end

    def call(string)
      @stdout.puts(string)
    end
  end
end
