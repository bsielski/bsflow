require_relative "./int_gen"
require_relative "./float_gen"
require_relative "./var_word_gen"
require_relative "./array_gen"
require_relative "./keyword_gen"

module VGen
  class HashGen
    def initialize(max_depth: 3)
      @max_depth = max_depth
    end
    
    def call(
          only: [
            IntGen.new,
            FloatGen.new,
            VarWordGen.new,
            ArrayGen.new,
            self.class.new,
            KeywordGen.new
          ],
          except: [],
          min: 4,
          max: 8
        )
      val_gens = [] + only
      val_gens.delete_if {|e| except.include? e.class}
      if @max_depth == 0
        val_gens.delete_if {|e| e.class == ArrayGen}
        val_gens.delete_if {|e| e.class == self.class}
      end
      if @max_depth > 0
        val_gens.map do |e|
          next e unless (e.class == ArrayGen || e.class == self.class)
          if e.class == ArrayGen
            next ArrayGen.new(max_depth: @max_depth - 1)
          end
          if e.class == self.class
            next self.class.new(max_depth: @max_depth - 1)
          end
        end
      end
      key_gens = [IntGen.new, VarWordGen.new, KeywordGen.new]
      hash = Hash[Array.new(Random.new.rand(min..max)) { [key_gens.sample.call, val_gens.sample.call] }]
    end
  end
end
