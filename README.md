# bsflow

A couple of classes that represent useful control flow patterns (conditional loops, pipelines etc.

## When to use it?

In pseudo-funtional programming.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bsflow'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bsflow

## Usage

Reqiure proper class.

```ruby
require "bsflow/pipeline"
```

Use it.

```ruby
square_number_generator = BSFlow:Pipeline.new(procs: [random_int, square])

```

All classes have just one public method: ***#call***.

Some classes have dependencies (injected in constructor) called "procs". They are objects that respond to ***#call*** method.

## API


### Class BSFlow::Pipeline

It passes a value through every proc and returns a final value. Output of the previous proc is input of the next proc.

Source code:

```ruby
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
```

#### Require

```ruby
require "bsflow/pipeline"
```

#### Constructor

```ruby
BSFlow:Pipeline.new(procs: procs) # => new_pipeline
```

Paramaters:

  - **_procs_** - an array of procs or objects responding on `.call` message. The first **_proc_** takes the "main" input of the class (any number of arguments). The result is passed to the next **_proc_** as input. The output of the last **_proc_** is the output of `.call` method of **Pipeline** class.


### Class BSFlow::FirstArg

It just returns first pased argument and ignores the rest. Used to reduce number of arguments.

Source code:

```ruby
module BSFlow
  class FirstArg
    def call(*args)
      args.first
    end
  end
end
```

#### Require

```ruby
require "bsflow/first_arg"
```

#### Constructor

```ruby
BSFlow:FirstArg.new # => new_first_arg
```


### Class BSFlow::LastArg

It just returns last pased argument and ignores the rest. Used to reduce number of arguments.

Source code:

```ruby
module BSFlow
  class LastArg
    def call(*args)
      args.last
    end
  end
end
```

#### Require

```ruby
require "bsflow/last_arg"
```

#### Constructor

```ruby
BSFlow:LastArg.new # => new_last_arg
```


### Class BSFlow::Self

It returns unmodified argument.

Source code:

```ruby
module BSFlow
  class Self
    def call(input)
      input
    end
  end
end
```

#### Require

```ruby
require "bsflow/self"
```

#### Constructor

```ruby
BSFlow:Self.new # => new_self
```

### Class BSFlow::True

It returns **_true_** no matter what input it takes.

Source code:

```ruby
module BSFlow
  class True
    def call(input)
      true
    end
  end
end
```

#### Require

```ruby
require "bsflow/true"
```

#### Constructor

```ruby
BSFlow:True.new # => new_true
```

### Class BSFlow::False

It returns **_false_** no matter what input it takes.

Source code:

```ruby
module BSFlow
  class False
    def call(input)
      false
    end
  end
end
```

#### Require

```ruby
require "bsflow/false"
```

#### Constructor

```ruby
BSFlow:False.new # => new_false
```

### Class BSFlow::Pass

It passes a value to a proc and returns the unmodified value. So it is a one way ticket for data but it is usefull for sending data to some output stream or queue.

Source code:

```ruby
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
```

#### Require

```ruby
require "bsflow/pass"
```

#### Constructor

```ruby
BSFlow:Pass.new(proc: proc) # => new_pass
```

Paramaters:

  - **_proc_** - an objects responding on `.call` message with one argument.

### Class BSFlow::Combine

It passes its `.call` arguments to each injected sub_proc, then it passes their outputs to injected combine_proc and returns the output.

Source code:

```ruby
module BSFlow
  class Combine
    def initialize(combine_proc:, sub_procs:)
      @sub_procs = sub_procs
      @combine_proc = combine_proc
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
```

#### Require

```ruby
require "bsflow/combine"
```

#### Constructor

```ruby
BSFlow::Combine.new(sub_procs: sub_procs, combine_proc: combine_proc) # => new_combine
```

Paramaters:

  - **_sub_procs_** - an array of procs or objects responding on `.call` message. Each of them takes arguments from combine object's call method and return an output. All aoutpus are pased to **_combine_proc_**.
  - **_combine_procs_** - a proc or object responding on `.call` message. The output of this proc is the output of the `.call` method of the **Combine** class.


### Class BSFlow::UntilTrueLoop

It passes input to condition_proc and if the result is not true it pases the input to loop_proc until the result is true.

Source code:

```ruby
module BSFlow
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
```

#### Require

```ruby
require "bsflow/until_true_loop"
```

#### Constructor

```ruby
BSFlow::UntilTrueLoop.new(condition_proc: condition_proc, loop_proc: loop_proc) # => new_loop
```

Paramaters:

  - **_condition_proc_** - proc or object responding on `.call` message with one argument. At the beginning it takes the input from `.call` method from UntilTrueLoop class. If an output is truthy the output is returned as the output of `.call` message of UntilTrueLoop class.
  - **_loop_proc_** - a proc or objects responding on `.call` message with one argument.


## To do features

  - Examples in the documentation and source code.
  - More classes.
  
## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
