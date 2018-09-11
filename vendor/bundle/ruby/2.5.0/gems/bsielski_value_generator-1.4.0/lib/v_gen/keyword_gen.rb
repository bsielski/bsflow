require_relative "./var_word_gen"

module VGen
  class KeywordGen
    def initialize(
          word_gen: VarWordGen.new
        )
      @word_gen = word_gen
    end

    def call()
      return @word_gen.call.to_sym
    end
  end
end
