module CFlow
  class Pipeline
    def initialize(procs:)
      @procs = procs
    end
    
    def call(input)
      @procs.each do |proc|
        input = proc.call(input)
      end
      input
    end
  end
end
