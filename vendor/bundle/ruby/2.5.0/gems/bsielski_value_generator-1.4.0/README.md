
# bsielski Value Generator

This gem can:
  - create random int, float, string, and symbols
  - create a random value of random type
  - create an array of random values
  - create a hash of random key and values

## Why to use it?

Who knows. I have made it when I was creating a code with functional style and was working mainly with hashes as a data containers and I wanted some configurable generator of random hashes for my unit tests.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bsielski_value_generator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bsielski_value_generator

## Usage

Reqiure proper class.

```ruby
require "v_gen/int_gen"
```

Use it.

```ruby
random_int = VGen::IntGen.new.call

# or

int_gen = VGen::IntGen.new
random_int = int_gen.call
```

All generators have just one public method: ***#call***.


## API


### Class VGen::IntGen

```ruby
require "v_gen/int_gen"
```

#### Constructor

```ruby
VGen::IntGen.new # => new_generator
```

Optionally paramaters:

  - **_range_** - is the range from which the number is randomly generated. Default is `(0..10)`.
  

#### Call

```ruby
VGen::IntGen.new.call # => new_int
```

### Class VGen::FloatGen

```ruby
require "v_gen/float_gen"
```
#### Constructor

```ruby
VGen::FloatGen.new # => new_generator
```

Optionally paramaters:

  - **_range_** - is the range from which the number is randomly generated. Default is `(-10..10)`.

#### Call

```ruby
VGen::FloatGen.new.call # => new_float
```

### Class VGen::LetterGen

```ruby
require "v_gen/letter_gen"
```

#### Constructor

```ruby
VGen::LetterGen.new # => new_generator
```

Optionally paramaters:

  - **_only:_** - an array (or range) of objects from which one randomly chosen is returned. Default is `("A".."Z").to_a + ("a".."z").to_a`.
  - **_except:_** - an array (or range) that is substracted from **_only:_** array (or range). Default is `[]`.

#### Call

```ruby
VGen::LetterGen.new.call # => new_letter
```

### Class VGen::LowerLetterGen

```ruby
require "v_gen/lower_letter_gen"
```

#### Constructor

```ruby
VGen::LowerLetterGen.new # => new_generator
```

Optionally paramaters:

  - **_only:_** - an array (or range) of objects from which one randomly chosen is returned. Default is `("A".."Z")` (those letters are downcased anyway by the class).
  - **_except:_** - an array (or range) that is substracted from **_only:_** array (or range). Default is `[]`.

#### Call

```ruby
VGen::LowerLetterGen.new.call # => new_lower_letter
```


### VGen::UpperLetterGen

```ruby
require "v_gen/upper_letter_gen"
```

#### Constructor

```ruby
VGen::UpperGen.new # => new_generator
```

Optionally paramaters:

  - **_only:_** - an array (or range) of objects from which one randomly chosen is returned. Default is `("A".."Z")`.
  - **_except:_** - an array (or range) that is substracted from **_only:_** array (or range). Default is `[]`.

#### Call

```ruby
VGen::UpperLetterGen.new.call # => new_upper_letter
```


### Class VGen::TypicalLetterGen

This generator returns random lower letters with with taking into account the frequency of occurrence in English language.

```ruby
require "v_gen/typical_letter_gen"
```

#### Constructor

```ruby
VGen::TypicalLetterGen.new # => new_generator
```

#### Call

```ruby
VGen::TypicalLetterGen.new.call # => new_letter
```

### Class VGen::CharGen

```ruby
require "v_gen/char_gen"
```

#### Constructor

```ruby
VGen::CharGen.new # => new_generator
```

Optionally paramaters:

  - **_only:_** - an array (or range) of objects from which one randomly chosen is returned. Default is:
```
  [
    "`", "~", "!", "@", "#", "$", "%", "^", "&",
	"*", "(", ")", "-", "_", "+", "=", "[", "{",
	"]", "}", "\\", "|", ";", ":", "'", "\"", "<",
	",", ">", ".", "?", "/", " "
  ] + ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
```
  - **_except:_** - an array (or range) that is substracted from **_only:_** array (or range). Default is `[]`.

#### Call

```ruby
VGen::CharGen.new.call # => new_char
```

### Class VGen::StringGen

This generator returns random strings.

```ruby
require "v_gen/string_gen"
```

#### Constructor

```ruby
VGen::StringGen.new # => new_generator
```

Optionally paramaters:

  - **_char_gen:_** - is a generator used to creating a characters for strings. Default is `VGen::LetterGen.new`.
  - **_length:_** - possible string length as a range (for random length) or an int (for fixed length).
  - **_except:_** - strings forbidden to generate. Default is `[]`.

#### Call

```ruby
VGen::StringGen.new.call # => new_string
```


### Class VGen::VarWordGen

This generator returns random lowercased strings sometimes with underscore in the middle of the string.

```ruby
require "v_gen/var_word_gen"
```

#### Constructor

```ruby
VGen::VarWordGen.new # => new_generator
```

Optionally paramaters:

  - **_letter_gen:_** - is a generator used to creating a letters for words. Default is `VGen::TypicalLetterGen.new`.
  - **_length:_** - possible word length as a range (for random length) or an int (for fixed length).
  - **_except:_** - words forbidden to generate. Default is `[]`.

#### Call

```ruby
VGen::VarWordGen.new.call # => new_word
```


### Class VGen::KeywordGen

This generator returns random lowercased symbols sometimes with underscore in the middle of the string.

```ruby
require "v_gen/keyword_gen"
```

#### Constructor

```ruby
VGen::KeywordGen.new # => new_generator
```

Optionally paramaters:

  - **_word_gen:_** - is a generator used to creating a string, which is converted into a symbos. Default is `VGen::VarWordGen.new`.

#### Call

```ruby
VGen::KeywordGen.new.call # => new_keyword
```

### Class VGen::ArrayGen

This generator returns an array of random values.

```ruby
require "v_gen/array_gen"
```

#### Constructor

```ruby
VGen::ArrayGen.new # => new_generator
```

Optionally paramaters:

  - **_min:_** - is a minimum size of a generated arrays. Default is `4`.
  - **_max:_** - is a maximum size of a generated arrays. Default is `9`.
  - **_length:_** - possible array length as a range (for random length) or an int (for fixed length).
  - **_gens:_** - are generators used randomly to generate values. Default is `[ proc {Random.new.rand} ]`.
  - **_uniq:_** - if truthy then generated arrays have unique elements. Default is `false`.

#### Call

```ruby
VGen::ArrayGen.new.call # => new_array
```


### Class VGen::HashGen

This generator returns a hash of random keys and values.

```ruby
require "v_gen/hash_gen"
```

#### Constructor

```ruby
VGen::HashGen.new # => new_generator
```

Optionally paramaters:

  - **_min:_** - is a minimum size of a generated hashes. Default is `4`.
  - **_max:_** - is a maximum size of a generated hashes. Default is `8`.
  - **_length:_** - possible hash length as a range (for random length) or an int (for fixed length).
  - **_key_gens:_** - are generators used randomly to generate keys. Default is `[ proc {Random.new.rand(0..100)} ]`.
  - **_value_gens:_** - are generators used randomly to generate values. Default is `[ proc {Random.new.rand} ]`.
  - **_with:_** - is a hash that must be included in the generated hash. In other words it is a obligatory set of key and values pairs. Default is `{}`.

#### Call

```ruby
VGen::HashGen.new.call # => new_array
```


### Class VGen::WhateverGen

This generator returns one value.

```ruby
require "bsielski_v_gen/int_gen"
```

#### Constructor

```ruby
VGen::WhateverGen.new # => new_generator
```

Optionally paramaters:

  - **_gens:_** - are generators used randomly to generate values. Default is `[ proc {Random.new.rand} ]`.

#### Call

```ruby
VGen::WhateverGen.new.call # => new_array
```


## Examples

Check "examples" folder.

## To do features

  - Some easy to use generators with default parameters

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
