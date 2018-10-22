SPECIAL_CHARS = [ "`", "~", "!", "@", "#", "$", "%", "^", "&",
                  "*", "(", ")", "-", "_", "+", "=", "[", "{",
                  "]", "}", "\\", "|", ";", ":", "'", "\"",
                  "<", ",", ">", ".", "?", "/", " " ]
LOWERCASE_LETTERS = ("a".."z").to_a
UPPERCASE_LETTERS = ("A".."Z").to_a
VERY_COMMON_LETTERS = %W{e t a o i n}
COMMON_LETTERS = %W{s h r d l}
RARE_LETTERS = %W{c u m w f g y p b}
VERY_RARE_LETTERS = %W{v k j x q z}
LETTERS = LOWERCASE_LETTERS + UPPERCASE_LETTERS
TYPICAL_LETTERS = ( VERY_COMMON_LETTERS * 8 ) +
                  ( COMMON_LETTERS * 4 ) +
                  ( RARE_LETTERS * 2 ) +
                  VERY_RARE_LETTERS
DIGITS = ("0".."9").to_a
CHARS = SPECIAL_CHARS + LETTERS + DIGITS

def random_char
  CHARS.sample
end

def typycal_letter
  TYPICAL_LETTERS.sample
end

def random_short_string
  length = Random.new.rand(0..5)
  Array.new(length) { random_char }.join
end

def random_long_string
  length = Random.new.rand(6..20)
  Array.new(length) { random_char }.join
end

def random_var_word
  length = Random.new.rand(4..9)
  Array.new(length) { typycal_letter }.join
end

def random_keyword
  random_var_word.to_sym
end

def random_single_value
  [ Random.new.rand(-100_000..100_000),
    Random.new.rand((-100_000.0)..(100_000.0)),
    random_short_string,
    random_long_string,
    random_keyword,
  ].sample
end

def random_flat_array
  length = Random.new.rand(2..100)
  Array.new(length) { random_single_value }
end

def random_flat_hash
  length = Random.new.rand(2..14)
  used_keys = []
  keys = Array.new(length) do
    loop do
      candidate_key = random_keyword
      if used_keys.include?(candidate_key)
        next
      else
        used_keys << candidate_key
        break candidate_key
      end
    end
  end
  values = Array.new(length) { random_single_value }
  Hash[keys.zip(values)]
end

def random_value
  [ random_single_value,
    random_single_value,
    random_single_value,
    random_flat_array,
    random_single_value,
    random_flat_hash,
    random_single_value,
  ].sample
end

def testing_array
    [ [],
      [random_value],
      random_flat_array
    ].sample
end
