require_relative "./typical_letter_gen"

module VGen
  class VarWordGen
    def initialize(
          letter_gen: TypicalLetterGen.new,
          length: nil,
          size: (4..9),
          except: []
        )
      @length = length || size
      @letter_gen = letter_gen
      @except = except
    end

    def call()
      
      loop do
        word = Array.new(
          word_length,
          @letter_gen
        ).map(&:call).join
        if word.size > 2
          if Random.new.rand(1..100) < 15
            word[Random.new.rand(1..word.size - 2)] = "_"
          end
        end
        return word unless @except.include? word
      end
    end
    
    private

    def word_length
      length = Random.new.rand(@length) if @length.is_a? Range
      length = @length if @length.is_a? Integer
      raise "length (size) can't be negative" if length < 0
      length
    end
  end
end
