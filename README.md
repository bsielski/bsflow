# bsielski Control Flow

A couple of classes for organizing objects in simple data flow structures (conditional loops, pipelines etc.).

## When to use it?

Who knows. Maybe in pseudo-funtional programming.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bsielski_control_flow'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bsielski_control_flow

## Usage

Reqiure proper class.

```ruby
require "c_flow/pipeline"
```

Use it.

```ruby
square_number_generator = CFlow:Pipeline.new(procs: [random_int, square])

```

All classes have just one public method: ***#call***. This method takes always one argument.

Some classes have dependencies (injected in constructor) called "procs". They are objects that respond to ***#call*** method. This method takes one argument or variable number of arguments (it depends of object's role).


## API


### Class CFlow::Pipeline

It passes a value through every proc and returns a final value. Output of the previous proc is input of the next proc.

Source code:

```ruby
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
```

#### Require

```ruby
require "c_flow/pipeline"
```

#### Constructor

```ruby
CFlow:Pipeline.new(procs: procs) # => new_pipeline
```

Paramaters:

  - **_procs_** - an array of procs or objects responding on `.call` message with one argument. The first **_proc_** takes the "main" input of the class. THe result is passed to the next **_proc_** as input. The output of the last **_proc_** is the output of `.call` method of **Pipeline** class.


### Class CFlow::Self

It returns unmodified argument.

Source code:

```ruby
module CFlow
  class Self
    def call(input)
      input
    end
  end
end
```

#### Require

```ruby
require "c_flow/self"
```

#### Constructor

```ruby
CFlow:Self.new # => new_self
```

### Class CFlow::True

It returns **_true_** no matter what input it takes.

Source code:

```ruby
module CFlow
  class True
    def call(input)
      true
    end
  end
end
```

#### Require

```ruby
require "c_flow/true"
```

#### Constructor

```ruby
CFlow:True.new # => new_true
```

### Class CFlow::False

It returns **_false_** no matter what input it takes.

Source code:

```ruby
module CFlow
  class False
    def call(input)
      false
    end
  end
end
```

#### Require

```ruby
require "c_flow/false"
```

#### Constructor

```ruby
CFlow:False.new # => new_false
```


### Class CFlow::Combine

It passes input to each helper proc, then it passes the outputs to one proc and returns the output.

Source code:

```ruby
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
```

#### Require

```ruby
require "c_flow/combine"
```

#### Constructor

```ruby
CFlow::Combine.new(sub_procs: sub_procs, combine_proc: combine_proc) # => new_combine
```

Paramaters:

  - **_sub_procs_** - an array of procs or objects responding on `.call` message with one argument. Each of them takes the "main" value a an argument and return an output. All aoutpus are pased to **_combine_proc_**.
  - **_combine_procs_** - a proc or object responding on `.call` message with one or many arguments. The output of this proc is the output of the `.call` method of the **Combine** class.
  

### Class CFlow::UntilTrueLoop

It passes input to condition_proc and if the result is not true it pases the input to loop_proc until the result is true.

Source code:

```ruby
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
```

#### Require

```ruby
require "c_flow/until_true_loop"
```

#### Constructor

```ruby
CFlow::UntilTrueLoop.new(condition_proc: condition_proc, loop_proc: loop_proc) # => new_loop
```

Paramaters:

  - **_condition_proc_** - proc or object responding on `.call` message with one argument. At the beginning it takes the input from `.call` method from UntilTrueLoop class. If an output is truthy the output is returned as the output of `.call` message of UntilTrueLoop class.
  - **_loop_proc_** - a proc or objects responding on `.call` message with one argument.


## To do features

  - Examples in the documentation and source code.
  - More classes.
  
## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
