require "v_gen/whatever_gen"
require "v_gen/int_gen"
require "v_gen/float_gen"
require "v_gen/string_gen"
require "v_gen/keyword_gen"
require "v_gen/char_gen"
require "v_gen/array_gen"
require "v_gen/hash_gen"

def random_value
  VGen::WhateverGen.new(
    gens: [
      VGen::IntGen.new(range=(-100_000..100_000)),
      VGen::FloatGen.new(range=(-100_000..100_000)),
      VGen::StringGen.new(char_gen: VGen::CharGen.new, length: (1..10)),
      VGen::KeywordGen.new,
      VGen::CharGen.new,
      VGen::ArrayGen.new(
        gens: [
          VGen::IntGen.new(range=(-100_000..100_000)),
          VGen::FloatGen.new(range=(-100_000..100_000)),
          VGen::StringGen.new(char_gen: VGen::CharGen.new(only: (0..9).to_a), length: (1..10)),
          VGen::KeywordGen.new,
          VGen::CharGen.new
        ]
      ),
      VGen::HashGen.new(
        key_gens: [
          VGen::IntGen.new(range=(-100_000..100_000)),
          VGen::StringGen.new(char_gen: VGen::CharGen.new, length: (1..10)),
          VGen::KeywordGen.new,
        ],
        value_gens: [
          VGen::IntGen.new(range=(-100_000..100_000)),
          VGen::FloatGen.new(range=(-100_000..100_000)),
          VGen::StringGen.new(char_gen: VGen::CharGen.new, length: (1..10)),
          VGen::KeywordGen.new,
          VGen::CharGen.new
        ]
      )
      
    ]      
  ).call
end

def unique_array(length)
  VGen::ArrayGen.new(
    uniq: true,
    length: length,
    gens: [
      VGen::IntGen.new(range=(-100_000..100_000)),
      VGen::FloatGen.new(range=(-100_000..100_000)),
      VGen::StringGen.new(char_gen: VGen::CharGen.new, length: (1..10)),
      VGen::KeywordGen.new,
      VGen::CharGen.new,
      VGen::ArrayGen.new(
        gens: [
          VGen::IntGen.new(range=(-100_000..100_000)),
          VGen::FloatGen.new(range=(-100_000..100_000)),
          VGen::StringGen.new(char_gen: VGen::CharGen.new(only: (0..9).to_a), length: (1..10)),
          VGen::KeywordGen.new,
          VGen::CharGen.new
        ]
      ),
      VGen::HashGen.new(
        key_gens: [
          VGen::IntGen.new(range=(-100_000..100_000)),
          VGen::StringGen.new(char_gen: VGen::CharGen.new, length: (1..10)),
          VGen::KeywordGen.new,
        ],
        value_gens: [
          VGen::IntGen.new(range=(-100_000..100_000)),
          VGen::FloatGen.new(range=(-100_000..100_000)),
          VGen::StringGen.new(char_gen: VGen::CharGen.new, length: (1..10)),
          VGen::KeywordGen.new,
          VGen::CharGen.new
        ]
      )
    ]      
  ).call
end
