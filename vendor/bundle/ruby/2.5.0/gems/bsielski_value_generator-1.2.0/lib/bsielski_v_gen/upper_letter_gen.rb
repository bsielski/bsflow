module VGen
  class UpperLetterGen
    def initialize(only: ("A".."Z"), except: [])
      @only, @except = only, except
    end

    def call()
      (@only.to_a.map(&:upcase) - @except.to_a.map(&:upcase))
        .sample
    end
  end
end
