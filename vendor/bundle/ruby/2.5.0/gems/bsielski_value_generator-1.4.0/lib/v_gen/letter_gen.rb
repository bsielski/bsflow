module VGen
  class LetterGen
    def initialize(
          only: (("A".."Z").to_a + ("a".."z").to_a),
          except: []
        )
      @only, @except = only, except
    end

    def call()
      (@only.to_a - @except.to_a).sample
    end
  end
end
