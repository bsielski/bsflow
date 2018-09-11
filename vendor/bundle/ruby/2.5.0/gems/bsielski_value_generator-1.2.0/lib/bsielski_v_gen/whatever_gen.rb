module VGen
  class WhateverGen
    def initialize(
          gens: [ proc {Random.new.rand} ]
        )
      @gens = gens
    end

    def call()
      @gens.sample.call
    end
  end
end
