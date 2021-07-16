#! /usr/bin/env ruby

# Inspired by https://gist.github.com/tiagoamaro/c82a27aceedfc901b081

require 'benchmark/ips'
require 'active_support/all'

require_relative '../lib/base_test_case.rb'

class TestCase < BaseTestCase
  ITERATIONS = 1

  def once(type: nil, key: nil)
    super(label: label(type), run_opts: { key: key })
  end

  def lots(type: nil, key: nil)
    super(label: label(type), run_opts: { key: key })
  end

  protected

  def run(opts = {})
    call(opts)
  end

  private

  def call(_)
    raise NotImplementedError
  end
end

class HashCase < TestCase
  attr_reader :hash

  def initialize(x)
    @hash = { a: 1, 'b' => 2 }

    super(x)
  end

  def run(opts = {})
    raise ArgumentError if opts[:key].nil?

    call(opts[:key])
  end
end

class HashFetch < HashCase
  LABEL = 'Hash#fetch'

  private

  def call(key = nil)
    hash.fetch(key)
  rescue
    nil
  end
end

class HashBrackets < HashCase
  LABEL = 'Hash#[]'

  private

  def call(key = nil)
    hash[key]
  end
end

class HashDig < HashCase
  LABEL = 'Hash#dig'

  private

  def call(key = nil)
    hash.dig(key)
  end
end

class HashWithIndifferentAccessFetch < HashCase
  LABEL = 'Hash#with_indifferent_access#fetch'

  private

  def call(key = nil)
    hash.with_indifferent_access.fetch(key)
  rescue
    nil
  end
end

class HashWithIndifferentAccessBrackets < HashCase
  LABEL = 'Hash#with_indifferent_access#[]'

  private

  def call(key = nil)
    hash.with_indifferent_access[key]
  end
end

class HashWithIndifferentAccessDig < HashCase
  LABEL = 'Hash#with_indifferent_access#dig'

  private

  def call(key = nil)
    hash.with_indifferent_access.dig(key)
  end
end

Benchmark.ips do |x|
  x.config(time: 5, warmup: 2)

  HashFetch.new(x).once(key: :a, type: 'symbol found')
  HashFetch.new(x).once(key: 'b', type: 'string found')
  HashFetch.new(x).once(key: :c, type: 'symbol not found')
  HashFetch.new(x).once(key: 'c', type: 'string not found')

  HashBrackets.new(x).once(key: :a, type: 'symbol found')
  HashBrackets.new(x).once(key: 'b', type: 'string found')
  HashBrackets.new(x).once(key: :c, type: 'symbol not found')
  HashBrackets.new(x).once(key: 'c', type: 'string not found')

  HashDig.new(x).once(key: :a, type: 'symbol found')
  HashDig.new(x).once(key: 'b', type: 'string found')
  HashDig.new(x).once(key: :c, type: 'symbol not found')
  HashDig.new(x).once(key: 'c', type: 'string not found')

  HashWithIndifferentAccessFetch.new(x).once(key: :a, type: 'symbol found by symbol')
  HashWithIndifferentAccessFetch.new(x).once(key: 'a', type: 'symbol found by string')
  HashWithIndifferentAccessFetch.new(x).once(key: :b, type: 'string found by symbol')
  HashWithIndifferentAccessFetch.new(x).once(key: 'b', type: 'string found by string')
  HashWithIndifferentAccessFetch.new(x).once(key: :c, type: 'symbol not found')
  HashWithIndifferentAccessFetch.new(x).once(key: 'c', type: 'string not found')

  HashWithIndifferentAccessBrackets.new(x).once(key: :a, type: 'symbol found by symbol')
  HashWithIndifferentAccessBrackets.new(x).once(key: 'a', type: 'symbol found by string')
  HashWithIndifferentAccessBrackets.new(x).once(key: :b, type: 'string found by symbol')
  HashWithIndifferentAccessBrackets.new(x).once(key: 'b', type: 'string found by string')
  HashWithIndifferentAccessBrackets.new(x).once(key: :c, type: 'symbol not found')
  HashWithIndifferentAccessBrackets.new(x).once(key: 'c', type: 'string not found')

  HashWithIndifferentAccessDig.new(x).once(key: :a, type: 'symbol found by symbol')
  HashWithIndifferentAccessDig.new(x).once(key: 'a', type: 'symbol found by string')
  HashWithIndifferentAccessDig.new(x).once(key: :b, type: 'string found by symbol')
  HashWithIndifferentAccessDig.new(x).once(key: 'b', type: 'string found by string')
  HashWithIndifferentAccessDig.new(x).once(key: :c, type: 'symbol not found')
  HashWithIndifferentAccessDig.new(x).once(key: 'c', type: 'string not found')

  x.compare!
end
