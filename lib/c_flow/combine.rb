module CFlow
  class Combine
    def initialize(combine_proc:, sub_procs:)
      @sub_procs = sub_procs
      @combine_proc = combine_proc
    end
    
    def call(input)
      sub_proc_outputs = []
      @sub_procs.each do |sub_proc|
        sub_proc_outputs << sub_proc.call(input)
      end
      @combine_proc.call(*sub_proc_outputs)
    end
  end
end
