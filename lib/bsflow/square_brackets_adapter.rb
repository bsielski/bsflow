module BSFlow
  class SquareBracketsAdapter
    def initialize(map:)
      @map = map
    end

    def call(symbol)
      @map[symbol]
    end
  end
end
