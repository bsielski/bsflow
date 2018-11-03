module BSFlow
  class DropArgs
    def initialize(proc:)
      @proc = proc
    end
    
    def call(*args)
      @proc.call
    end
  end
end
