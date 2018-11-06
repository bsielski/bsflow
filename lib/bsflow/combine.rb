module BSFlow
  class Combine
    def initialize(*args, combine_proc: nil, sub_procs: [])
      if combine_proc
        @sub_procs = sub_procs
        @combine_proc = combine_proc
      else
        @sub_procs = args[0..-2]
        @combine_proc = args.last
      end
    end
    
    def call(*args)
      sub_proc_outputs = []
      @sub_procs.each do |sub_proc|
        sub_proc_outputs << sub_proc.call(*args)
      end
      @combine_proc.call(*sub_proc_outputs)
    end
  end
end
