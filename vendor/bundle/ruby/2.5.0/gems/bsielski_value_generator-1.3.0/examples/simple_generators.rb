require_relative "../lib/v_gen/letter_gen"
require_relative "../lib/v_gen/string_gen"
require_relative "../lib/v_gen/array_gen"
require_relative "../lib/v_gen/hash_gen"
require_relative "../lib/v_gen/int_gen"
require_relative "../lib/v_gen/float_gen"
require_relative "../lib/v_gen/var_word_gen"
require_relative "../lib/v_gen/keyword_gen"
require_relative "../lib/v_gen/whatever_gen"

number_of = 3

digitGen = VGen::LetterGen.new(
  only: %W[0 1 2 3 4 5 6 7 8 9]
)

puts "*** digitGen ***"
number_of.times do
  puts digitGen.call.inspect
end

numberStringGen = VGen::StringGen.new(
    char_gen: digitGen,
    length: (1..10)
)

puts "*** numberStringGen ***"
number_of.times do
  puts numberStringGen.call.inspect
end

specialCharGen = VGen::LetterGen.new(
  only: %W[
    ` ~ ! @ # $ % ^ & * ( ) - _ + =
    [ { ] } \\ | ; : ' \" < , > . ? / 
  ] + [" "]
)

puts "*** specialCharGen ***"
number_of.times do
  puts specialCharGen.call.inspect
end

popularSpecialCharGen = VGen::LetterGen.new(
  only: %W[ ! ? ( ) _ , . ] + [" "]
)

puts "*** popularSpecialCharGen ***"
number_of.times do
  puts popularSpecialCharGen.call.inspect
end

noneCollectionValueGen = VGen::WhateverGen.new(
    gens: [
      VGen::IntGen.new(range=(-100_000..100_000)),
      VGen::FloatGen.new(range=(-100_000..100_000)),
      VGen::VarWordGen.new(length: (1..10)),
      numberStringGen,
      VGen::KeywordGen.new,
      VGen::KeywordGen.new(word_gen: numberStringGen),
    ]

)

puts "*** noneCollectionValueGen ***"
number_of.times do
  puts noneCollectionValueGen.call.inspect
end

leafArrayGen = VGen::ArrayGen.new(
  length: (0..5),
  gens: [noneCollectionValueGen]
)

puts "*** leafArrayGen ***"
number_of.times do
  puts leafArrayGen.call.inspect
end

digitsArrayGen = VGen::ArrayGen.new(
  length: (6..10),
  gens: [digitGen]
)

puts "*** digitsArrayGen ***"
number_of.times do
  puts digitsArrayGen.call.inspect
end

uniqueDigitsArrayGen = VGen::ArrayGen.new(
  length: (6..10),
  gens: [digitGen],
  uniq: true
)

puts "*** uniqueDigitsArrayGen ***"
number_of.times do
  puts uniqueDigitsArrayGen.call.inspect
end

leafHashGen = VGen::HashGen.new(
  length: (0..4),
    key_gens: [VGen::IntGen.new, VGen::KeywordGen.new],
    value_gens: [noneCollectionValueGen] 
)

puts "*** leafHashGen ***"
number_of.times do
  puts leafHashGen.call.inspect
end

userHashGen = VGen::HashGen.new(
  length: (1..4),
  key_gens: [VGen::IntGen.new, VGen::KeywordGen.new],
  value_gens: [noneCollectionValueGen],
  with: { name: "John"}
)

puts "*** userHashGen ***"
number_of.times do
  puts userHashGen.call.inspect
end
