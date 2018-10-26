module BSFlow
  class StdinAdapter
    def initialize(stdin:)
      @stdin = stdin
    end

    def call()
      @stdin.gets.chomp
    end
  end
end
