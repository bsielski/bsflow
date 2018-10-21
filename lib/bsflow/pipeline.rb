module BSFlow
  class Pipeline
    def initialize(procs:)
      @procs = procs
    end
    
    def call(*args)
      output = @procs[0].call(*args)
      if @procs.length == 1
        return output
      else
        @procs[1..-1].each do |proc|
          output = proc.call(output)
        end
        output
      end
    end
  end
end
