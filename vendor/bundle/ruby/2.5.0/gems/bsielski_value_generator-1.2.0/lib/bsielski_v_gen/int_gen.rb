module VGen
  class IntGen
    def initialize(
          range=(0..10)
        )
      @range = range
    end

    def call()
      Random.new.rand(@range)
    end
  end
end
