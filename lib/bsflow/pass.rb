module BSFlow
  class Pass
    def initialize(proc:)
      @proc = proc
    end
    
    def call(input)
      @proc.call(input)
      input
    end
  end
end
