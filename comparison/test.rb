#! /usr/bin/env ruby

require 'benchmark'
require 'benchmark/ips'

require_relative '../lib/base_test_case.rb'

class TestCase < BaseTestCase
  def once(type: nil, code: nil)
    super(label: label(type), run_opts: { code: code })
  end

  def lots(type: nil, code: nil)
    super(label: label(type), run_opts: { code: code })
  end

  protected

  def run(opts = {})
    return all_codes if opts[:code].nil?

    call(opts[:code])
  end

  private

  def all_codes
    (100..599).each do |code|
      call(code)
    end
  end

  def call(_)
    raise NotImplementedError
  end
end

class TestCaseA < TestCase
  LABEL = 'cover?'.freeze

  private

  def call(code)
    (200..299).cover?(code)
  end
end

class TestCaseB < TestCase
  LABEL = '< >='.freeze

  def call(code)
    code < 300 && code >= 200
  end
end

class TestCaseC < TestCase
  LABEL = 'between?'.freeze

  def call(code)
    code.between?(200, 299)
  end
end

class TestCaseD < TestCase
  EXPECTED_RESPONSE_CODES = [200, 201, 202, 203, 204, 205, 206, 207, 208, 226].freeze
  LABEL = 'include?'.freeze

  def call(code)
    EXPECTED_RESPONSE_CODES.include?(code)
  end
end

Benchmark.bm(8) do |x|
  TestCaseA.new(x).lots
  TestCaseB.new(x).lots
  TestCaseC.new(x).lots
  TestCaseD.new(x).lots
end

Benchmark.ips do |x|
  x.config(time: 5, warmup: 2)

  tca = TestCaseA.new(x)
  tcb = TestCaseB.new(x)
  tcc = TestCaseC.new(x)
  tcd = TestCaseD.new(x)

  tca.once(code: 200, type: 'found')
  tca.once(code: 300, type: 'not found')

  tcb.once(code: 200, type: 'found')
  tcb.once(code: 300, type: 'not found')

  tcc.once(code: 200, type: 'found')
  tcc.once(code: 300, type: 'not found')

  tcd.once(code: 200, type: 'found')
  tcd.once(code: 300, type: 'not found')

  x.compare!
end
