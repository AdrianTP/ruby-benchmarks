#! /usr/bin/env ruby

# Inspired by https://gist.github.com/tiagoamaro/c82a27aceedfc901b081

require 'benchmark/ips'
require 'active_support/all'

Benchmark.ips do |x|
  x.config(time: 5, warmup: 2)

  @hash = { a: 1, 'b' => 2 }
  @indifferent_hash = { a: 1, 'b' => 2 }.with_indifferent_access

  x.report('Hash#fetch symbol found') do
    @hash.fetch(:a)
  end

  x.report('Hash#fetch string found') do
    @hash.fetch('b')
  end

  x.report('Hash#fetch symbol not found') do
    @hash.fetch(:c)
  rescue
    nil
  end

  x.report('Hash#fetch string not found') do
    @hash.fetch('c')
  rescue
    nil
  end

  x.report('Hash#[] symbol found') do
    @hash[:a]
  end

  x.report('Hash#[] string found') do
    @hash['b']
  end

  x.report('Hash#[] symbol not found') do
    @hash[:c]
  end

  x.report('Hash#[] string not found') do
    @hash['c']
  end

  x.report('Hash#dig symbol found') do
    @hash.dig(:a)
  end

  x.report('Hash#dig string found') do
    @hash.dig('b')
  end

  x.report('Hash#dig symbol not found') do
    @hash.dig(:c)
  end

  x.report('Hash#dig string not found') do
    @hash.dig('c')
  end

  x.report('Hash#with_indifferent_access#fetch symbol found by symbol') do
    @hash.with_indifferent_access.fetch(:a)
  end

  x.report('Hash#with_indifferent_access#fetch symbol found by string') do
    @hash.with_indifferent_access.fetch('a')
  end

  x.report('Hash#with_indifferent_access#fetch string found by symbol') do
    @hash.with_indifferent_access.fetch(:b)
  end

  x.report('Hash#with_indifferent_access#fetch string found by string') do
    @hash.with_indifferent_access.fetch('b')
  end

  x.report('Hash#with_indifferent_access#fetch symbol not found') do
    @hash.with_indifferent_access.fetch(:c)
  rescue
    nil
  end

  x.report('Hash#with_indifferent_access#fetch string not found') do
    @hash.with_indifferent_access.fetch('c')
  rescue
    nil
  end

  x.report('Hash#with_indifferent_access#[] symbol found by symbol') do
    @hash.with_indifferent_access[:a]
  end

  x.report('Hash#with_indifferent_access#[] symbol found by string') do
    @hash.with_indifferent_access['a']
  end

  x.report('Hash#with_indifferent_access#[] string found by symbol') do
    @hash.with_indifferent_access[:b]
  end

  x.report('Hash#with_indifferent_access#[] string found by string') do
    @hash.with_indifferent_access['b']
  end

  x.report('Hash#with_indifferent_access#[] symbol not found') do
    @hash.with_indifferent_access[:c]
  end

  x.report('Hash#with_indifferent_access#[] string not found') do
    @hash.with_indifferent_access['c']
  end

  x.report('Hash#with_indifferent_access#dig symbol found by symbol') do
    @hash.with_indifferent_access.dig(:a)
  end

  x.report('Hash#with_indifferent_access#dig symbol found by string') do
    @hash.with_indifferent_access.dig('a')
  end

  x.report('Hash#with_indifferent_access#dig string found by symbol') do
    @hash.with_indifferent_access.dig(:b)
  end

  x.report('Hash#with_indifferent_access#dig string found by string') do
    @hash.with_indifferent_access.dig('b')
  end

  x.report('Hash#with_indifferent_access#dig symbol not found') do
    @hash.with_indifferent_access.dig(:c)
  end

  x.report('Hash#with_indifferent_access#dig string not found') do
    @hash.with_indifferent_access.dig('c')
  end

  x.report('indifferent Hash#fetch symbol found by symbol') do
    @indifferent_hash.fetch(:a)
  end

  x.report('indifferent Hash#fetch symbol found by string') do
    @indifferent_hash.fetch('a')
  end

  x.report('indifferent Hash#fetch string found by symbol') do
    @indifferent_hash.fetch(:b)
  end

  x.report('indifferent Hash#fetch string found by string') do
    @indifferent_hash.fetch('b')
  end

  x.report('indifferent Hash#fetch symbol not found') do
    @indifferent_hash.fetch(:c)
  rescue
    nil
  end

  x.report('indifferent Hash#fetch string not found') do
    @indifferent_hash.fetch('c')
  rescue
    nil
  end

  x.report('indifferent Hash#[] symbol found by symbol') do
    @indifferent_hash[:a]
  end

  x.report('indifferent Hash#[] symbol found by string') do
    @indifferent_hash['a']
  end

  x.report('indifferent Hash#[] string found by symbol') do
    @indifferent_hash[:b]
  end

  x.report('indifferent Hash#[] string found by string') do
    @indifferent_hash['b']
  end

  x.report('indifferent Hash#[] symbol not found') do
    @indifferent_hash[:c]
  end

  x.report('indifferent Hash#[] string not found') do
    @indifferent_hash['c']
  end

  x.report('indifferent Hash#dig symbol found by symbol') do
    @indifferent_hash.dig(:a)
  end

  x.report('indifferent Hash#dig symbol found by string') do
    @indifferent_hash.dig('a')
  end

  x.report('indifferent Hash#dig string found by symbol') do
    @indifferent_hash.dig(:b)
  end

  x.report('indifferent Hash#dig string found by string') do
    @indifferent_hash.dig('b')
  end

  x.report('indifferent Hash#dig symbol not found') do
    @indifferent_hash.dig(:c)
  end

  x.report('indifferent Hash#dig string not found') do
    @indifferent_hash.dig('c')
  end

  x.compare!
end
