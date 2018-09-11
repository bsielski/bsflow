module VGen
  class CharGen
    attr_reader :char_gen
    def initialize(
          only: [
            "`", "~", "!", "@", "#", "$", "%", "^",
            "&", "*", "(", ")", "-", "_", "+", "=",
            "[", "{", "]", "}", "\\", "|", ";", ":",
            "'", "\"", "<", ",", ">", ".", "?", "/",
            " "
          ] + ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a,
          except: []
        )
      @only, @except = only, except
    end
    
    def call()
      (@only.to_a - @except.to_a).sample
    end
  end
end
