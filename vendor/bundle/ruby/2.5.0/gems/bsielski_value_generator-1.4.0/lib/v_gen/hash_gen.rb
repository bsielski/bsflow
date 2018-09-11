module VGen
  class HashGen
    def initialize(
          with: {},
          min: 4,
          max: 8,
          length: nil,
          size: nil,
          key_gens:   [ proc {Random.new.rand(0..100)} ],
          value_gens: [ proc {Random.new.rand} ]
        )
      @with = with
      @length = length || size || (min..max)
      @key_gens = key_gens
      @value_gens = value_gens
      @min = min
      @max = max
    end
    
    def call()
      with_length = @with.length
      hash = Hash[
        Array.new(hash_length - with_length) do
          [
            @key_gens.sample.call,
            @value_gens.sample.call
          ]
        end
      ]
      unless @with.empty?
        hash.merge!(@with)
      end
      while hash.size < hash_length do
        new_pair =  {
          @key_gens.sample.call => @value_gens.sample.call
        }
        hash = new_pair.merge(hash)  
      end
      hash = hash.to_a.shuffle.to_h unless @with.empty?
      hash
    end

    private

    def hash_length
      length = Random.new.rand(@length) if @length.is_a? Range
      length = @length if @length.is_a? Integer
      raise "length (size) can't be negative" if length < 0
      length
    end
  end
end
