module VGen
  class ArrayGen
    def initialize(
          uniq: false,
          min: 4,
          max: 9,
          length: nil,
          size: nil,
          gens: [ proc {Random.new.rand} ]
        )
      @uniq = uniq
      @length = length || size || (min..max)
      @gens = gens
      @min = min
      @max = max
    end

    def call()
      used_values = []
      Array.new(array_length) {
        loop do
          candidate_value = @gens.sample.call
          if used_values.include?(candidate_value)
            next
          else
            used_values << candidate_value if @uniq
            break candidate_value
          end
        end
      }
    end
        
    private

    def array_length
      length = Random.new.rand(@length) if @length.is_a? Range
      length = @length if @length.is_a? Integer
      raise "length (size) can't be negative" if length < 0
      length
    end
  end
end
