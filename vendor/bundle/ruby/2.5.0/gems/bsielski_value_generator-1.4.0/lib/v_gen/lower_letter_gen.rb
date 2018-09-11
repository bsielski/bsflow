module VGen
  class LowerLetterGen
    def initialize(only: ("A".."Z"), except: [])
      @only, @except = only, except
    end

    def call()
      (@only.to_a.map(&:downcase) - @except.to_a.map(&:downcase))
        .sample
    end
  end
end
