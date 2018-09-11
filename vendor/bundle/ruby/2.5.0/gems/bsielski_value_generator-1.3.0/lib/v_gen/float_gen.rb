module VGen
  class FloatGen
    def initialize(
          range=(-10..10)
        )
      @range = range
    end

    def call()
      Random.new.rand(
        (@range.min.to_f..@range.max.to_f)
      )
    end
  end
end
