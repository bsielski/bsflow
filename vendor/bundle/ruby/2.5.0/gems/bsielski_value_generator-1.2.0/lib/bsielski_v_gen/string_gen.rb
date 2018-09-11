require_relative "./letter_gen"

module VGen
  class StringGen
    attr_reader :char_gen
    def initialize(
          char_gen: LetterGen.new,
          length: (4..9),
          except: []
        )
      @length = length
      @char_gen = char_gen
      @except = except
    end

    def call()
      
      loop do
        word = Array.new(
          word_length,
          @char_gen
        ).map(&:call).join
        return word unless @except.include? word
      end
    end
    
    private

    def word_length
      length = Random.new.rand(@length) if @length.is_a? Range
      length = @length if @length.is_a? Integer
      length
    end
  end
end
