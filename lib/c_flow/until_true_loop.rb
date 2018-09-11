module CFlow
  class UntilTrueLoop
    def initialize(condition_proc:, loop_proc:)
      @loop_proc = loop_proc
      @condition_proc = condition_proc
    end
    
    def call(input)
      until @condition_proc.call(input) do
        input = @loop_proc.call(input)
      end
      input
    end
  end
end
