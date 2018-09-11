require_relative "./int_gen"
require_relative "./float_gen"
require_relative "./var_word_gen"
require_relative "./hash_gen"
require_relative "./keyword_gen"

module VGen
  class ArrayGen
    def initialize(max_depth: 3)
      @max_depth = max_depth
    end
    
    def call(
          only: [
            IntGen.new,
            FloatGen.new,
            VarWordGen.new,
            self.class.new,
            KeywordGen.new
          ],
          except: [],
          min: 4,
          max: 8)
      gens = [] + only
      gens.delete_if {|e| except.include? e.class}
      if @max_depth == 0
        gens.delete_if {|e| e.class == self.class}
      end
      if @max_depth > 0
        gens = gens.map do |e|
          next e unless e.class == self.class
          if e.class == self.class
            next self.class.new(max_depth: @max_depth - 1)
          end
        end
      end
      arr = Array.new(Random.new.rand(min..max)) { gens.sample }
      arr.map(&:call)
    end
  end
end
